//
//  SBUserEditViewController.m
//  SoundBite
//
//  Created by John Keyes on 12/25/12.
//  Copyright (c) 2012 John Keyes. All rights reserved.
//

#import "SBUserEditViewController.h"


@implementation SBUserEditViewController

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
    
    self.validated = NO;
    
	if (self.editMode) {
		self.navigationItem.title = @"Edit User";
		self.userNameField.text = self.user.userName;
		self.passwordField.text = self.user.password;
		self.stackField.text = self.user.stack;
        self.stack = self.user.stack;
		self.accountField.text = self.user.account;
	} else {
        //TODO: BUG The title is not getting set...
		self.navigationItem.title = @"Add User";
		self.userNameField.text = @"";
		self.passwordField.text = @"";
		self.stackField.text = @"";
		self.accountField.text = @"";
	}
}


- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"SBUserEditViewController: viewWillDisappear");
	//self.user.userName = self.userNameField.text;
	//self.user.password = self.passwordField.text;
	//self.user.stack = self.stackField.text;
	//self.user.account = self.accountField.text;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)userSaveButton:(id)sender {
    NSLog(@"SBUserEditViewController: userSaveButton");
    
    self.user.userName = self.userNameField.text;
    self.user.password = self.passwordField.text;
    self.user.stack = self.stackField.text;
    self.user.account = self.accountField.text;
    
    [self validateUser:self.user delegate:self];
}

- (void)validateUser:(User *)user delegate:(id)delegate {
    SBSoap2 *sbSoap;
    
    if ((user.userName.length > 2) && (user.password.length > 2) && (user.stack.length > 2)) {
        
        sbSoap = [[SBSoap2 alloc] init];
        sbSoap.currentUser = self.user;
        
        NSURL *url = [SBSoap2 sbSoapCreateURL:(user.stack) service:kPlatformManagementService];
        NSString *request = [SBSoap2 sbSoapCreateRequest:user soapBody:kshowSystemInfo];
        
        [sbSoap sbSoapSendRequest:url request:request delegate:delegate];
        
        NSLog(@"validateUser: initiated request");

        /*
		sbSoap = [[SBSoap2 alloc] init];
		[sbSoap request:user requestTemplate:kshowSystemInfoRequestTemplateV2 urlTemplate:kshowSystemInfoUrlTemplateV2 delegate:delegate];
		NSLog(@"validateUser: just called request");
        */
	} else {
		NSString *msg = @"Please fill in your user details.";
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login error" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];		
    }
}

- (void)dataIsReady:(SBSoap2 *)sbSoapReady {
	NSString *msg = nil;
	UIAlertView *alert = nil;
    
    //TODO: This is incorrectly reporting invalid logins as valid.
    //TODO: No error is reported if there is a connection error (e.g. xbad stack name)
    
	if (sbSoapReady.error) {
        
        // Bad login; do not dismiss.
		self.validated = NO;
		if (self.user.userName.length > 0)
			msg = [[NSString alloc] initWithFormat:@"Can't authenticate %@ on stack %@.", self.user.userName, self.user.stack];
		else
			msg = @"Can't authenticate using the credentials provided.";
		alert = [[UIAlertView alloc] initWithTitle:@"Login error" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
	} else {
        NSLog(@"SBUserEditViewController: good login");
        // Good login; can tell parent to dismiss the user detail page.

		self.validated = YES;
        [self.delegate userDidDismissUserEditViewController:self];
	}
}

- (IBAction)userCancelButton:(id)sender {
    NSLog(@"SBUserEditViewController: userCancelButton");
    
    // TODO: Remove the user that was created or undo changes.
    
    self.validated = NO;
    [self.delegate userDidDismissUserEditViewController:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
    NSLog(@"row = %d", [indexPath row]);
    
    if ([indexPath row] == 2) {
        [self performSegueWithIdentifier:@"ShowStacks" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowStacks"]) {
        SBStacksViewController *stacksViewController = segue.destinationViewController;
        stacksViewController.delegate = self;
        stacksViewController.stack = self.stack;
    }
}

- (void)stacksViewController:(SBStacksViewController *)controller didSelectStack:(NSString *)stack {
    self.stack = stack;
    self.stackField.text = stack;
    [self.navigationController popViewControllerAnimated:YES];
}


@end
