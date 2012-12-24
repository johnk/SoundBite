//
//  User.h
//  SoundBite
//
//  Created by John Keyes on 5/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CWLSynthesizeSingleton.h"

@interface User : NSObject <NSCoding> {
	NSString *userName;
	NSString *password;
	NSString *stack;
	NSString *account;
}

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *stack;
@property (nonatomic, strong) NSString *account;

- (id)initWithUserOnStack:(NSString *)newStack name:(NSString *)newUserName password:(NSString *)newPassword account:(NSString *)newAccount;
- (void)encodeWithCoder:(NSCoder *)coder;
- (id)initWithCoder:(NSCoder *)coder;

@end
