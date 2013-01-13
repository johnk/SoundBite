//
//  SBSubCampaignDetailViewController.h
//  SoundBite
//
//  Created by John Keyes on 1/5/13.
//  Copyright (c) 2013 John Keyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBSubCampaigns.h"
#import "User.h"
#import "SBSubCampaignDetailCell.h"
#import "SBPassDetailCell.h"

@interface SBSubCampaignDetailViewController : UITableViewController

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) SBSoap2 *sbSoap;
@property (nonatomic, strong) NSTimer *refreshSCTimer;
@property (nonatomic, strong) UIColor *refreshButtonColor;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButton;

- (void)dataIsReady:(SBSoap2 *)sbSoap;

@end
