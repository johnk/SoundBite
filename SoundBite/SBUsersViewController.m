//
//  SBUsersViewController.m
//  SoundBite
//
//  Created by John Keyes on 12/23/12.
//  Copyright (c) 2012 John Keyes. All rights reserved.
//

#import "SBUsersViewController.h"
#import "SBAppDelegate.h"


@interface SBUsersViewController ()

@property (nonatomic, retain) Users *users;

@end


@implementation SBUsersViewController

// Used from a storyboard.

- (void)awakeFromNib
{
    SBAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	self.users = appDelegate.users;

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

// Not used from a storyboard.

- (void)viewDidLoad
{
    [super viewDidLoad];

    /*
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
								  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
								  target:self
								  action:@selector(addUser:)];
	self.navigationItem.rightBarButtonItem = addButton;

    self.userEditViewController = (SBUserEditViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];

	SBAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	self.users = appDelegate.users;
    */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addUser:(id)sender {
	[self.users addNewUser];
	NSUInteger newUserIndex = [self.users count] - 1;
	NSLog(@"Adding new user with index %i", newUserIndex);
	
    //TODO: Need to segue to the user edit view controller.
    
    //SBUserEditViewController *userEditViewController = [[SBUserEditViewController alloc] initWithNibName:@"UserEditView" bundle:nil];
	//userEditViewController.user = (users.userArray)[newUserIndex];
	//userEditViewController.editMode = NO;
	//[self.navigationController pushViewController:userEditViewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.tableView reloadData];	// in case a user was edited
	[self.users save];
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
    //[cell.imageView setImage:[UIImage imageNamed:@"user.png"]];
    cell.textLabel.text = [(self.users.userArray)[row] userName];
	NSLog(@"cell %@", cell.textLabel);
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if (editingStyle == UITableViewCellEditingStyleDelete) {
    //    [_objects removeObjectAtIndex:indexPath.row];
    //    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    //} else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    //}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    //    NSDate *object = _objects[indexPath.row];
    //    self.detailViewController.detailItem = object;
    //}

	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	NSUInteger row = [indexPath row];
	if (self.editing) {
		//SBUserEditViewController *userEditViewController = [[SBUserEditViewController alloc] initWithNibName:@"UserEditView" bundle:nil];
		//userEditViewController.user = (users.userArray)[row];
		//userEditViewController.editMode = YES;
		//[self.navigationController pushViewController:userEditViewController animated:YES];
	} else {
		//MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc] initWithNibName:@"MainMenuView" bundle:nil];
		//mainMenuViewController.user = (users.userArray)[row];
		//[self.navigationController pushViewController:mainMenuViewController animated:YES];
	}
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"SBUsersViewController: prepareForSegue");
    
    if ([[segue identifier] isEqualToString:@"ShowMainMenu"]) {
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //NSDate *object = _objects[indexPath.row];
        //[[segue destinationViewController] setDetailItem:object];
        [segue destinationViewController];
    } else if ([[segue identifier] isEqualToString:@"ShowAddUser"]) {
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //NSDate *object = _objects[indexPath.row];
        //[[segue destinationViewController] setDetailItem:object];
        [segue destinationViewController];

    }
}

@end

