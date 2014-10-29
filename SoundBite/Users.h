//
//  Users.h
//  SoundBite
//
//  Created by John Keyes on 5/17/09.
//  Copyright 2012 John Keyes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Users : NSObject <NSCoding>

@property (nonatomic, strong) NSMutableArray *userArray;

- (void)load;
@property (NS_NONATOMIC_IOSONLY, readonly) NSUInteger count;
- (void)addNewUser;
- (void)removeLastUser;
- (void)save;
- (void)encodeWithCoder:(NSCoder *)coder;
- (instancetype)initWithCoder:(NSCoder *)coder NS_DESIGNATED_INITIALIZER;

@end
