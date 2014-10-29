//
//  SBMainMenuViewController.m
//  SoundBite
//
//  Created by John Keyes on 1/5/13.
//  Copyright (c) 2013 John Keyes. All rights reserved.
//

#define kCampaigns	0
#define kAgents     1
#define kLists		2
#define kScripts	3
#define	kReports	4
#define	kInfo		5

#import "SBMainMenuViewController.h"
#import "SBCampaignsViewController.h"
#import "SBScriptsViewController.h"
#import "SBListsViewController.h"
#import "SBSystemInfoViewController.h"


@interface SBMainMenuViewController () {
    NSArray *mainMenuItems;
    UITableView *tv;
}

@end

@implementation SBMainMenuViewController

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
    
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view delegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSString *sectionHeader = [[NSString alloc] initWithFormat:@"%@ (%@)", self.user.account, self.user.stack];
	return sectionHeader;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row];
	if ((row == kCampaigns) || (row == kScripts) || (row == kLists) || (row == kInfo))
		return indexPath;
	else
		return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
    
    if ([[segue identifier] isEqualToString:@"ShowCampaigns"]) {
        SBCampaignsViewController *destViewController = segue.destinationViewController;
        destViewController.user = self.user;
    } else if ([[segue identifier] isEqualToString:@"ShowScripts"]) {
        SBScriptsViewController *destViewController = segue.destinationViewController;
        destViewController.user = self.user;
    } else if ([[segue identifier] isEqualToString:@"ShowLists"]) {
        SBListsViewController *destViewController = segue.destinationViewController;
        destViewController.user = self.user;
    } else if ([[segue identifier] isEqualToString:@"ShowSystemInfo"]) {
        SBSystemInfoViewController *destViewController = segue.destinationViewController;
        destViewController.user = self.user;
    }
}

@end
