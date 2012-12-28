//
//  SBUserEditViewController.m
//  SoundBite
//
//  Created by John Keyes on 12/25/12.
//  Copyright (c) 2012 John Keyes. All rights reserved.
//

#import "SBUserEditViewController.h"

@interface SBUserEditViewController ()

@property (nonatomic, retain) SBSoap2 *ss;

@end

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
		self.accountField.text = self.user.account;
	} else {
		self.navigationItem.title = @"Add User";
		self.userNameField.text = @"";
		self.passwordField.text = @"";
		self.stackField.text = @"";
		self.accountField.text = @"";
	}
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

// TODO: Move this into the suer object a a validateUser method.
- (IBAction)validateUser:(id)sender {
	// Try to log in; see if it works.   ??? we are not validating the account # here
	self.user.userName = self.userNameField.text;
	self.user.password = self.passwordField.text;
	self.user.stack = self.stackField.text;
	self.user.account = self.accountField.text;
    
	if ((self.userNameField.text.length > 2) && (self.passwordField.text.length > 2) && (self.stackField.text.length > 2)) {
        
		self.ss = [[SBSoap2 alloc] init];
		[self.ss request:self.user requestTemplate:kshowSystemInfoRequestTemplate urlTemplate:kshowSystemInfoUrlTemplate delegate:self];
		NSLog(@"just called request");
	} else {
		// fail
		self.validated = NO;
		NSString *msg = @"Please fill in your user details.";
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login error" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		
		// put a red x on a label somewhere
	}
}

- (void)dataIsReady:(SBSoap2 *)sbSoapReady {
	NSString *msg = nil;
	UIAlertView *alert = nil;
    
    //TODO: This is incorrectly reporting invalid logins as valid.
	if (sbSoapReady.error) {
		self.validated = NO;
		if (self.user.userName.length > 0)
			msg = [[NSString alloc] initWithFormat:@"Can't authenticate %@ on stack %@.", self.user.userName, self.user.stack];
		else
			msg = @"Can't authenticate using the credentials provided.";
		alert = [[UIAlertView alloc] initWithTitle:@"Login error" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	} else {
		self.validated = YES;
		msg = [[NSString alloc] initWithFormat:@"User %@ on stack %@ is valid.", self.user.userName, self.user.stack];
		alert = [[UIAlertView alloc] initWithTitle:@"Success" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		// put a green check mark somewhere
	}
	[alert show];
}

- (IBAction)userSaveButton:(id)sender {
    NSLog(@"SBUserEditViewController: userSaveButton");

    // TODO: validate the user here
    
	self.user.userName = self.userNameField.text;
	self.user.password = self.passwordField.text;
	self.user.stack = self.stackField.text;
	self.user.account = self.accountField.text;
    
    // Tell the parent view controller to dismiss us.
}

- (IBAction)userCancelButton:(id)sender {
    NSLog(@"SBUserEditViewController: userCancelButton");

    // Tell the parent view controller to dismiss us.
}

@end
