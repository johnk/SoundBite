//
//  SBAppDelegate.h
//  SoundBite
//
//  Created by John Keyes on 12/23/12.
//  Copyright (c) 2012 John Keyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Users.h"


@interface SBAppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) Users *users;

@end
