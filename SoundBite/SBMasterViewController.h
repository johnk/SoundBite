//
//  SBMasterViewController.h
//  SoundBite
//
//  Created by John Keyes on 12/23/12.
//  Copyright (c) 2012 John Keyes. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBDetailViewController;

@interface SBMasterViewController : UITableViewController

@property (strong, nonatomic) SBDetailViewController *detailViewController;

@end
