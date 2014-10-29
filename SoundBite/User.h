//
//  User.h
//  SoundBite
//
//  Created by John Keyes on 5/13/09.
//  Copyright 2012 John Keyes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CWLSynthesizeSingleton.h"

@interface User : NSObject <NSCoding>

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *stack;
@property (nonatomic, strong) NSString *account;

- (instancetype)initWithUserOnStack:(NSString *)newStack name:(NSString *)newUserName password:(NSString *)newPassword account:(NSString *)newAccount NS_DESIGNATED_INITIALIZER;
- (void)encodeWithCoder:(NSCoder *)coder;
- (instancetype)initWithCoder:(NSCoder *)coder NS_DESIGNATED_INITIALIZER;

@end
