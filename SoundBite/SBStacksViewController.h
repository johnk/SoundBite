//
//  SBStacksViewController.h
//  SoundBite
//
//  Created by John Keyes on 3/29/14.
//  Copyright (c) 2014 John Keyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBStacks.h"

@class SBStacksViewController;

@protocol SBStacksViewControllerDelegate <NSObject>

- (void)stacksViewController:(SBStacksViewController *)controller didSelectStack:(NSString *)stack;

@end

@interface SBStacksViewController : UITableViewController

//@property (nonatomic) NSUInteger currentStack;
//@property (nonatomic, strong) NSString *currentStackValue;

@property (nonatomic, weak) id <SBStacksViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString *stack;
@property (nonatomic) NSUInteger stackIndex;

@end
