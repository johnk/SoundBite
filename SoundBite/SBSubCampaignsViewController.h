//
//  SBSubCampaignsViewController.h
//  SoundBite
//
//  Created by John Keyes on 1/5/13.
//  Copyright (c) 2013 John Keyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "SBSoap2.h"
#import "SBSubCampaigns.h"
#import "SBSubCampaignDetailViewController.h"

@interface SBSubCampaignsViewController : UITableViewController

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) SBSoap2 *sbSoap;

- (void)dataIsReady:(SBSoap2 *)sbSoap;

@end
