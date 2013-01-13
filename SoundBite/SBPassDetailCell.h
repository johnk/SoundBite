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

@end
