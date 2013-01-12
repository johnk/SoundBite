//
//  SBSubCampaignDetailCell.h
//  SoundBite
//
//  Created by John Keyes on 1/12/13.
//  Copyright (c) 2013 John Keyes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBSubCampaignDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *scStatus;
@property (weak, nonatomic) IBOutlet UILabel *scPctAttempted;
@property (weak, nonatomic) IBOutlet UIProgressView *scProgressAttempted;
@property (weak, nonatomic) IBOutlet UILabel *scPctDelivered;
@property (weak, nonatomic) IBOutlet UIProgressView *scProgressDelivered;
@property (weak, nonatomic) IBOutlet UILabel *scAllContacts;
@property (weak, nonatomic) IBOutlet UILabel *scFiltered;
@property (weak, nonatomic) IBOutlet UILabel *scAvailable;
@property (weak, nonatomic) IBOutlet UILabel *scDelivered;
@property (weak, nonatomic) IBOutlet UILabel *scNotDelivered;
@property (weak, nonatomic) IBOutlet UILabel *scNotAttempted;


@end
