//
//  SBSubCampaignDetailViewController.m
//  SoundBite
//
//  Created by John Keyes on 1/5/13.
//  Copyright (c) 2013 John Keyes. All rights reserved.
//

#import "SBSubCampaignDetailViewController.h"

@interface SBSubCampaignDetailViewController ()

@end

@implementation SBSubCampaignDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
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
    
    self.refreshSCTimer = [NSTimer timerWithTimeInterval:5.0f target:self selector:@selector(reloadSC:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.refreshSCTimer forMode:NSRunLoopCommonModes];
}

- (void)dataIsReady:(SBSoap2 *)sbSoapReady {
	NSLog(@"SubCampaign data is ready");
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
    // TODO: This will be one main section, plus one for the passes.
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
            // PassDetailCell(s) - 1 cell per pass
            // TODO: return the number of passes
            return 3;
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float percentAttempted, percentDelivered;

    if (indexPath.section == 0) {
        SBSubCampaignDetailCell *cell = (SBSubCampaignDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"SubCampaignDetailCell" forIndexPath:indexPath];
        
        NSUInteger row = [[SBSubCampaigns sharedSBSubCampaigns] currentRow];
        
        cell.scStatus.text = [[SBSubCampaigns sharedSBSubCampaigns] statusForRow:row];
        
        //double attempted = [[SBSubCampaigns sharedSBSubCampaigns] attemptedCountForRow:row].intValue;
        double notAttempted = [[SBSubCampaigns sharedSBSubCampaigns] notAttemptedCountForRow:row].intValue;
        double filtered = [[SBSubCampaigns sharedSBSubCampaigns] filteredCountForRow:row].intValue;
        //double pending = [[SBSubCampaigns sharedSBSubCampaigns] pendingCountForRow:row].intValue;
        double delivered = [[SBSubCampaigns sharedSBSubCampaigns] deliveredCountForRow:row].intValue;
        double failed = [[SBSubCampaigns sharedSBSubCampaigns] failedCountForRow:row].intValue;
        double available = delivered + failed + notAttempted;

        if (available > 0) {
            percentAttempted = (delivered + failed) / available;
            percentDelivered = delivered / available;
        } else {
            percentAttempted = 0.0;
            percentDelivered = 0.0;
        }
         
        cell.scPctAttempted.text = [NSString stringWithFormat:@"%.f%%", percentAttempted * 100];
        cell.scPctDelivered.text = [NSString stringWithFormat:@"%.f%%", percentDelivered * 100];
         
        [cell.scProgressAttempted setProgress:percentAttempted animated:YES];
        [cell.scProgressDelivered setProgress:percentDelivered animated:YES];
         
        // http://stackoverflow.com/questions/2233824/how-to-add-commas-to-number-every-3-digits-in-objective-c
        // http://stackoverflow.com/questions/169925/how-to-do-string-conversions-in-objective-c
         
        cell.scAllContacts.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithInt:(delivered + failed + notAttempted + filtered)] numberStyle:NSNumberFormatterDecimalStyle];
         
        cell.scFiltered.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithInt:filtered] numberStyle:NSNumberFormatterDecimalStyle];
         
        cell.scAvailable.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithInt:(delivered + failed + notAttempted)] numberStyle:NSNumberFormatterDecimalStyle];
         
        cell.scDelivered.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithInt:delivered] numberStyle:NSNumberFormatterDecimalStyle];
         
        cell.scNotDelivered.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithInt:failed] numberStyle:NSNumberFormatterDecimalStyle];
         
        cell.scNotAttempted.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithInt:notAttempted] numberStyle:NSNumberFormatterDecimalStyle];

        return cell;
        
    } else if (indexPath.section == 1) {
        // PassDetailCell(s) - 1 cell per pass
        
        SBPassDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PassDetailCell" forIndexPath:indexPath];
        
        // TODO: Setup the cell information for the pass.
        
        return cell;
    } 
    
    return nil;
}

// Not sure why this is needed if a custom cell height is set in the storyboard.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0)
        return 280;
    else
        return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSUInteger currentUser = [[SBSubCampaigns sharedSBSubCampaigns] currentRow];

    switch (section) {
        case 0:
            //self.campaignName.text = [[SBSubCampaigns sharedSBSubCampaigns] currentCampaign];
            return [[SBSubCampaigns sharedSBSubCampaigns] nameForRow:currentUser];

            //return @"sub-campaign name";
            break;
        
        case 1:
            return @"Passes";
            
        default:
            break;
    }
    return nil;
    // return [[SBSubCampaigns sharedSBSubCampaigns] currentCampaign];
}

- (IBAction)reloadSC:(id)sender {
	NSLog(@"SubCampaignDetailViewController: reloadSC");
    
    // self.scStatus.textColor = [UIColor redColor];    
    [[SBSubCampaigns sharedSBSubCampaigns] loadForUser:[[SBSubCampaigns sharedSBSubCampaigns] currentUser] withDelegate:self];
}

@end
