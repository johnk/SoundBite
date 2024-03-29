//
//  SBUserEditViewController.h
//  SoundBite
//
//  Created by John Keyes on 12/25/12.
//  Copyright (c) 2012 John Keyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "SBSoap2.h"
#import "SBStacksViewController.h"

@protocol SBUserEditViewControllerDelegate;

@interface SBUserEditViewController : UITableViewController <SBStacksViewControllerDelegate>

@property (strong, nonatomic) User *user;
@property BOOL editMode;
@property BOOL validated;
@property (weak, nonatomic) id<SBUserEditViewControllerDelegate>delegate;
@property (nonatomic, strong) NSString *stack;

@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *stackField;
@property (weak, nonatomic) IBOutlet UITextField *accountField;


//@property (nonatomic, retain) SBSoap2 *sbSoap;

@end

@protocol SBUserEditViewControllerDelegate <NSObject>

- (void)userDidDismissUserEditViewController:(SBUserEditViewController *)userEditViewController;

@end