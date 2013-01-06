//
//  SBCampaignsViewController.m
//  SoundBite
//
//  Created by John Keyes on 1/5/13.
//  Copyright (c) 2013 John Keyes. All rights reserved.
//

#import "SBCampaignsViewController.h"
#import "SBSubCampaignsViewController.h"

@interface SBCampaignsViewController ()

@end

@implementation SBCampaignsViewController

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
    [[SBCampaigns sharedSBCampaigns] loadForUser:self.user withDelegate:self];
}

- (void)dataIsReady:(SBSoap2 *)sbSoapReady {
	NSLog(@"Campaign data is ready");
	if (sbSoapReady.error) {
		NSString *msg = nil;
		if (self.user.userName.length > 0)
			msg = [[NSString alloc] initWithFormat:@"Can't authenticate %@ on stack %@.", self.user.userName, self.user.stack];
		else
			msg = @"Can't authenticate using the credentials provided.";
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login error" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		[alert show];
	} else {
		NSLog(@"Reloading Campaign data in table");
		[self.tableView reloadData];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[SBCampaigns sharedSBCampaigns] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CampaignsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSUInteger row = [indexPath row];
    
	cell.textLabel.text = [[SBCampaigns sharedSBCampaigns] nameForRow:row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", [[SBCampaigns sharedSBCampaigns] startDateForRow:row], [[SBCampaigns sharedSBCampaigns] endDateForRow:row]];
    
    return cell;
}

#pragma mark - Table view delegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);

    NSUInteger row = [indexPath row];
    [SBSubCampaigns sharedSBSubCampaigns].currentCampaign = [[SBCampaigns sharedSBCampaigns] nameForRow:row];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
    
    if ([[segue identifier] isEqualToString:@"ShowSubCampaigns"]) {
        SBSubCampaignsViewController *subCampaignsViewController = segue.destinationViewController;
		subCampaignsViewController.user = self.user;
    }
}

@end
