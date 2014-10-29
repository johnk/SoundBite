//
//  SBSubCampaignDetailViewController.m
//  SoundBite
//
//  Created by John Keyes on 1/5/13.
//  Copyright (c) 2013 John Keyes. All rights reserved.
//

#import "SBSubCampaignDetailViewController.h"
#import "ChannelTypes.h"

@interface SBSubCampaignDetailViewController ()

@end

@implementation SBSubCampaignDetailViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    //self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.refreshButtonColor = [self.refreshButton tintColor];

    self.refreshSCTimer = [NSTimer timerWithTimeInterval:5.0f target:self selector:@selector(reloadSC:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.refreshSCTimer forMode:NSRunLoopCommonModes];
}

- (void)dataIsReady:(SBSoap2 *)sbSoapReady {
	NSLog(@"SubCampaign data is ready");
    [self.refreshControl endRefreshing];

	if (sbSoapReady.error) {
        User *user = [[SBSubCampaigns sharedSBSubCampaigns] currentUser];
		NSString *msg = nil;
		if (user.userName.length > 0)
			msg = [[NSString alloc] initWithFormat:@"Can't authenticate %@ on stack %@.", user.userName, user.stack];
		else
			msg = @"Can't authenticate using the credentials provided.";
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login error" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		[alert show];
	} else {
		NSLog(@"Reloading SubCampaign data in table");
        [self.tableView reloadData];
        [self.refreshButton setTintColor:self.refreshButtonColor];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"invalidate timer");
    [self.refreshSCTimer invalidate];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // One main section, plus one for the passes.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            // SubCampaignDetailCell - 1 cell total
            return 1;
            break;
        
        case 1:
        {
            // PassDetailCell(s) - 1 cell per pass
            NSUInteger row = [[SBSubCampaigns sharedSBSubCampaigns] currentRow];
            NSUInteger passCount = [[SBSubCampaigns sharedSBSubCampaigns] countPassesForSub:row];
            return passCount;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float percentAttempted, percentDelivered;
	double notAttempted, filtered, delivered, failed, available;
	//double attempted, pending;
	NSDictionary *dict;

    NSUInteger row = [[SBSubCampaigns sharedSBSubCampaigns] currentRow];
	
    if (indexPath.section == 0)
		dict = [[SBSubCampaigns sharedSBSubCampaigns] getAttributesForSub:row];
    else if (indexPath.section == 1)
        dict = [[SBSubCampaigns sharedSBSubCampaigns] getAttributesForSub:row pass:indexPath.row];
	else return nil;

	// The potentially available attributes are:
	// attemptedCount, deliveredCount, failedCount, pendingCount, filteredCount, notAttemptedCount
	// dcHandledLast15, dcAverageTalkTime, adjustSLA, dcFailedLast15, dcFailed, dcHandled, activeCount
	// dcAverageTalkTimeLast15, attemptedCountLast15, afterContactWorkCount, thisHourContacts, nextHourContacts, futureContacts, 
	
	notAttempted = [dict[@"notAttemptedCount"] doubleValue];
	filtered = [dict[@"filteredCount"] doubleValue];
	delivered = [dict[@"deliveredCount"] doubleValue];
	failed = [dict[@"failedCount"] doubleValue];
	available = delivered + failed + notAttempted;
	
	/*
	attempted = [[SBSubCampaigns sharedSBSubCampaigns] attemptedCountForRow:row].intValue;
	notAttempted = [[SBSubCampaigns sharedSBSubCampaigns] notAttemptedCountForRow:row].intValue;
	filtered = [[SBSubCampaigns sharedSBSubCampaigns] filteredCountForRow:row].intValue;
	pending = [[SBSubCampaigns sharedSBSubCampaigns] pendingCountForRow:row].intValue;
	delivered = [[SBSubCampaigns sharedSBSubCampaigns] deliveredCountForRow:row].intValue;
	failed = [[SBSubCampaigns sharedSBSubCampaigns] failedCountForRow:row].intValue;
	available = delivered + failed + notAttempted;
	*/
	
	if (available > 0) {
		percentAttempted = (delivered + failed) / available;
		percentDelivered = delivered / available;
	} else {
		percentAttempted = 0.0;
		percentDelivered = 0.0;
	}
	
    if (indexPath.section == 0) {
		SBSubCampaignDetailCell *cell = (SBSubCampaignDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"SubCampaignDetailCell" forIndexPath:indexPath];
	
        NSString * scStatus = [[SBSubCampaigns sharedSBSubCampaigns] statusForRow:row];
        [self setScButtonsForStatus:scStatus];
        //cell.scStatus.text = scStatus;
        
        cell.scPctAttempted.text = [NSString stringWithFormat:@"%.f%%", percentAttempted * 100];
        cell.scPctDelivered.text = [NSString stringWithFormat:@"%.f%%", percentDelivered * 100];
         
        [cell.scProgressAttempted setProgress:percentAttempted animated:YES];
        [cell.scProgressDelivered setProgress:percentDelivered animated:YES];
         
        // http://stackoverflow.com/questions/2233824/how-to-add-commas-to-number-every-3-digits-in-objective-c
        // http://stackoverflow.com/questions/169925/how-to-do-string-conversions-in-objective-c
         
        cell.scAllContacts.text = [NSNumberFormatter localizedStringFromNumber:@((int)(delivered + failed + notAttempted + filtered)) numberStyle:NSNumberFormatterDecimalStyle];
        
        cell.scFiltered.text = [NSNumberFormatter localizedStringFromNumber:@((int)filtered) numberStyle:NSNumberFormatterDecimalStyle];
        cell.scPctFiltered.text = [NSString stringWithFormat:@"%.f%%", filtered / (delivered + failed + notAttempted + filtered) * 100];
        
        cell.scAvailable.text = [NSNumberFormatter localizedStringFromNumber:@((int)(delivered + failed + notAttempted)) numberStyle:NSNumberFormatterDecimalStyle];
        cell.scPctAvailable.text = [NSString stringWithFormat:@"%.f%%", available / (delivered + failed + notAttempted + filtered) * 100];
        
        cell.scDelivered.text = [NSNumberFormatter localizedStringFromNumber:@((int)delivered) numberStyle:NSNumberFormatterDecimalStyle];
        cell.scPctDelivered2.text = [NSString stringWithFormat:@"%.f%%", delivered / available * 100];
        
        cell.scNotDelivered.text = [NSNumberFormatter localizedStringFromNumber:@((int)failed) numberStyle:NSNumberFormatterDecimalStyle];
        cell.scPctNotDelivered.text = [NSString stringWithFormat:@"%.f%%", failed / available * 100];
        
        cell.scNotAttempted.text = [NSNumberFormatter localizedStringFromNumber:@((int)notAttempted) numberStyle:NSNumberFormatterDecimalStyle];
        cell.scPctNotAttempted.text = [NSString stringWithFormat:@"%.f%%", notAttempted / available * 100];

        return cell;
    } else if (indexPath.section == 1) {
		SBPassDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PassDetailCell" forIndexPath:indexPath];

        NSInteger channelType = [[SBSubCampaigns sharedSBSubCampaigns] passChannelForSub:row pass:indexPath.row];
		[cell.passTypeImage setImage:[UIImage imageNamed:[self iconFileForChannelType:(NSInteger)channelType]]];

        NSString *passName = [[SBSubCampaigns sharedSBSubCampaigns] passNameForSub:row pass:indexPath.row];
        NSString *passStatus = [[SBSubCampaigns sharedSBSubCampaigns] passStatusForSub:row pass:indexPath.row];
        cell.passName.text = [NSString stringWithFormat:@"%@ (%@)", passName, passStatus];
        
        cell.passAvailable.text = [NSNumberFormatter localizedStringFromNumber:@((int)(delivered + failed + notAttempted)) numberStyle:NSNumberFormatterDecimalStyle];
		
        cell.passPctAttempted.text = [NSString stringWithFormat:@"%.f%%", percentAttempted * 100];
        [cell.passProgressAttempted setProgress:percentAttempted animated:YES];
		cell.passAttempted.text = [NSNumberFormatter localizedStringFromNumber:@((int)(delivered + failed)) numberStyle:NSNumberFormatterDecimalStyle];

        cell.passPctDelivered.text = [NSString stringWithFormat:@"%.f%%", percentDelivered * 100];
        [cell.passProgressDelivered setProgress:percentDelivered animated:YES];
        cell.passDelivered.text = [NSNumberFormatter localizedStringFromNumber:@((int)delivered) numberStyle:NSNumberFormatterDecimalStyle];
         
        return cell;
    } 
    return nil;
}

- (NSString *)iconFileForChannelType:(NSInteger)channelType {
	NSString *channelImageName;
	
	switch (channelType) {
		case CHANNEL_TYPE_VOICE:
			channelImageName = CHANNEL_ICON_VOICE;
			break;
		case CHANNEL_TYPE_EMAIL:
			channelImageName = CHANNEL_ICON_EMAIL;
			break;
		case CHANNEL_TYPE_TEXT:
			channelImageName = CHANNEL_ICON_TEXT;
			break;
		case CHANNEL_TYPE_DIALER:
			channelImageName = CHANNEL_ICON_DIALER;
			break;
		case CHANNEL_TYPE_PREVIEW:
			channelImageName = CHANNEL_ICON_PREVIEW;
			break;
		case CHANNEL_TYPE_MANUAL:
			channelImageName = CHANNEL_ICON_MANUAL;
			break;
		case CHANNEL_TYPE_WEB:
			channelImageName = CHANNEL_ICON_WEB;
			break;
		default:
			channelImageName = CHANNEL_ICON_NONE;
			break;
	}
	return channelImageName;
}

// Not sure why this is needed if a custom cell height is set in the storyboard.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0)
        return 220;
    else
        return 66;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSUInteger row = [[SBSubCampaigns sharedSBSubCampaigns] currentRow];

    switch (section) {
        case 0:
            //self.campaignName.text = [[SBSubCampaigns sharedSBSubCampaigns] currentCampaign];
            //return [[SBSubCampaigns sharedSBSubCampaigns] nameForRow:row];
            return [NSString stringWithFormat:@"%@ (%@)", [[SBSubCampaigns sharedSBSubCampaigns] nameForRow:row], [[SBSubCampaigns sharedSBSubCampaigns] statusForRow:row]];
            break;
        
        case 1:
        {
            NSUInteger passCount = [[SBSubCampaigns sharedSBSubCampaigns] countPassesForSub:row];
            NSString *passHeader = [NSString stringWithFormat:@"Passes (%lu)", (unsigned long)passCount];
            return passHeader;
        }
        default:
            break;
    }
    return nil;
    // return [[SBSubCampaigns sharedSBSubCampaigns] currentCampaign];
}

- (IBAction)refreshSC:(UIRefreshControl *)sender {
	NSLog(@"SubCampaignDetailViewController: refreshSC");
    [self.refreshControl beginRefreshing];
    [self.refreshButton setTintColor:[UIColor darkGrayColor]];
    // self.scStatus.textColor = [UIColor redColor];
    [[SBSubCampaigns sharedSBSubCampaigns] loadForUser:[[SBSubCampaigns sharedSBSubCampaigns] currentUser] withDelegate:self];
}

// This and the refresh button may go away...?
- (IBAction)reloadSC:(id)sender {
	NSLog(@"SubCampaignDetailViewController: reloadSC");
    [self.refreshControl beginRefreshing];
    [self.refreshButton setTintColor:[UIColor darkGrayColor]];
    // self.scStatus.textColor = [UIColor redColor];
    [[SBSubCampaigns sharedSBSubCampaigns] loadForUser:[[SBSubCampaigns sharedSBSubCampaigns] currentUser] withDelegate:self];
}

- (void)setScButtonsForStatus:(NSString *)status {
    if ([status isEqualToString:kscStatusLoading]) {
        self.scPlayButton.enabled = NO;
        self.scPauseButton.enabled = NO;
        self.scStopButton.enabled = NO;
    } else if ([status isEqualToString:kscStatusRunning]) {
        self.scPlayButton.enabled = NO;
        self.scPauseButton.enabled = YES;
        self.scStopButton.enabled = YES;
    } else if ([status isEqualToString:kscStatusPaused]) {
        self.scPlayButton.enabled = YES;
        self.scPauseButton.enabled = NO;
        self.scStopButton.enabled = YES;
    } else if ([status isEqualToString:kscStatusPending]) {
        self.scPlayButton.enabled = NO;
        self.scPauseButton.enabled = YES;
        self.scStopButton.enabled = YES;
    } else if ([status isEqualToString:kscStatusStopping]) {
        self.scPlayButton.enabled = NO;
        self.scPauseButton.enabled = NO;
        self.scStopButton.enabled = NO;
    } else {
        self.scPlayButton.enabled = NO;
        self.scPauseButton.enabled = NO;
        self.scStopButton.enabled = NO;
    }
}

- (IBAction)scPlay:(UIBarButtonItem *)sender {
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
    [[SBSubCampaigns sharedSBSubCampaigns] changeScStatus:kscStatusRunning];
}

- (IBAction)scPause:(UIBarButtonItem *)sender {
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
    [[SBSubCampaigns sharedSBSubCampaigns] changeScStatus:kscStatusPaused];
}

- (IBAction)scStop:(UIBarButtonItem *)sender {
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
    [[SBSubCampaigns sharedSBSubCampaigns] changeScStatus:kscStatusStopping];
}


@end
