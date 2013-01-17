//
//  SBPassDetailCell.h
//  SoundBite
//
//  Created by John Keyes on 1/12/13.
//  Copyright (c) 2013 John Keyes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBPassDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *passName;
@property (weak, nonatomic) IBOutlet UIImageView *passTypeImage;

@property (weak, nonatomic) IBOutlet UILabel *passAvailable;
@property (weak, nonatomic) IBOutlet UILabel *passStatus;
@property (weak, nonatomic) IBOutlet UILabel *passPctAttempted;
@property (weak, nonatomic) IBOutlet UIProgressView *passProgressAttempted;
@property (weak, nonatomic) IBOutlet UILabel *passAttempted;
@property (weak, nonatomic) IBOutlet UILabel *passPctDelivered;
@property (weak, nonatomic) IBOutlet UIProgressView *passProgressDelivered;
@property (weak, nonatomic) IBOutlet UILabel *passDelivered;

@end
