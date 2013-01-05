//
//  SBUsersViewController.m
//  SoundBite
//
//  Created by John Keyes on 12/23/12.
//  Copyright (c) 2012 John Keyes. All rights reserved.
//

#import "SBUsersViewController.h"
#import "SBAppDelegate.h"


@interface SBUsersViewController ()<SBUserEditViewControllerDelegate>

@property (nonatomic, retain) Users *users;

@end


@implementation SBUsersViewController

// Used from a storyboard.
- (void)awakeFromNib
{
    SBAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    if (!appDelegate.users) {
        self.users = [[Users alloc] init];
        appDelegate.users = self.users;
        [self.users load];
    } else {
        self.users = appDelegate.users;
    }

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.tableView reloadData];	// in case a user was edited
	[self.users save];
}

- (void)userDidDismissUserEditViewController:(SBUserEditViewController *)userEditViewController {
    if (!userEditViewController.validated) {
        // Remove the user slot we added, unless its an existing user.
        if (!userEditViewController.editMode)
            [self.users removeLastUser];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UsersCell" forIndexPath:indexPath];
    
	NSUInteger row = [indexPath row];
    cell.textLabel.text = [(self.users.userArray)[row] userName];
	NSLog(@"cell %@", cell.textLabel);
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    NSLog(@"SBUsersViewController: didSelectRowAtIndexPath");

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        //NSDate *object = _objects[indexPath.row];
        //self.detailViewController.detailItem = object;
    }

	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	NSUInteger row = [indexPath row];
    
	if (self.editing) {
		//userEditViewController.user = (users.userArray)[row];
		userEditViewController.editMode = YES;
	} else {
		//mainMenuViewController.user = (users.userArray)[row];
		//[self.navigationController pushViewController:mainMenuViewController animated:YES];
	}
    */
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);

    UINavigationController *navController = segue.destinationViewController;

    if ([[segue identifier] isEqualToString:@"ShowMainMenu"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        
    } else if ([[segue identifier] isEqualToString:@"ShowAddUser"]) {
        NSLog(@"SBUsersViewController: prepareForSegue ShowAddUser");
        
        SBUserEditViewController *userEditViewController = (SBUserEditViewController *)[[navController viewControllers] objectAtIndex:0];
        
        [self.users addNewUser];
        NSUInteger newUserIndex = [self.users count] - 1;
        NSLog(@"Adding new user with index %i", newUserIndex);
        
        userEditViewController.user = (self.users.userArray)[newUserIndex];
        userEditViewController.editMode = NO;
        userEditViewController.delegate = self;
    }
}

#pragma mark Editing

// Set the editing state of the view controller. We pass this down to the table view and also modify the content
// of the table to insert a placeholder row for adding content when in editing mode.
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
	[self.tableView beginUpdates];
    [self.tableView setEditing:editing animated:YES];
    if (editing) {
        // Show the placeholder rows
        //[self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
		NSLog(@"setEditing editing");
    } else {
        // Hide the placeholder rows.
        //[self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
		NSLog(@"setEditing not editing");
    }
    [self.tableView endUpdates];
}

// Update the data model according to edit actions delete or insert.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSUInteger row = [indexPath row];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
		[self.users.userArray removeObjectAtIndex:row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return NO;
}

@end

