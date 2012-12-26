//
//  SBUsersViewController.h
//  SoundBite
//
//  Created by John Keyes on 12/23/12.
//  Copyright (c) 2012 John Keyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Users.h"
#import "SBUserEditViewController.h"


@class SBDetailViewController;

@interface SBUsersViewController : UITableViewController

@property (strong, nonatomic) SBUserEditViewController *userEditViewController;

@end
