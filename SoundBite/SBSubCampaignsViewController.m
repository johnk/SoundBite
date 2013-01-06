//
//  SBSubCampaignsViewController.m
//  SoundBite
//
//  Created by John Keyes on 1/5/13.
//  Copyright (c) 2013 John Keyes. All rights reserved.
//

#import "SBSubCampaignsViewController.h"

@interface SBSubCampaignsViewController ()

@end

@implementation SBSubCampaignsViewController

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
    [[SBSubCampaigns sharedSBSubCampaigns] loadForUser:self.user withDelegate:self];
}

- (void)dataIsReady:(SBSoap2 *)sbSoapReady {
	NSLog(@"SubCampaign data is ready");
	if (sbSoapReady.error) {
		NSString *msg = nil;
		if (self.user.userName.length > 0)
			msg = [[NSString alloc] initWithFormat:@"Can't authenticate %@ on stack %@.", self.user.userName, self.user.stack];
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
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[SBSubCampaigns sharedSBSubCampaigns] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SubCampaignsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
	NSUInteger row = [indexPath row];
	
	cell.textLabel.text = [[SBSubCampaigns sharedSBSubCampaigns] nameForRow:row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%@ delivered of %@ attempted)",
                            [[SBSubCampaigns sharedSBSubCampaigns] statusForRow:row],
                            [[SBSubCampaigns sharedSBSubCampaigns] deliveredCountForRow:row],
                            [[SBSubCampaigns sharedSBSubCampaigns] attemptedCountForRow:row]];
    
    return cell;
}

#pragma mark - Table view delegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
    
    if ([[segue identifier] isEqualToString:@"ShowSubCampaignDetail"]) {
        SBSubCampaignDetailViewController *subCampaignDetailViewController = segue.destinationViewController;
		subCampaignDetailViewController.user = self.user;
    }
}

@end
