//
//  SBUserEditViewController.h
//  SoundBite
//
//  Created by John Keyes on 12/25/12.
//  Copyright (c) 2012 John Keyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@protocol SBUserEditViewControllerDelegate;

@interface SBUserEditViewController : UITableViewController

@property (strong, nonatomic) User *user;
@property BOOL editMode;
@property BOOL validated;
@property (weak, nonatomic) id<SBUserEditViewControllerDelegate>delegate;

@end

@protocol SBUserEditViewControllerDelegate <NSObject>

- (void)userDidDismissUserEditViewController:(SBUserEditViewController *)userEditViewController;

@end