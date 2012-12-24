//
//  User.m
//  SoundBite
//
//  Created by John Keyes on 5/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize userName;
@synthesize password;
@synthesize stack;
@synthesize account;

- (id)initWithUserOnStack:(NSString *)newStack name:(NSString *)newUserName password:(NSString *)newPassword account:(NSString *) newAccount {
	if (!(self = [super init])) return nil;
	self.userName = newUserName;
	self.password = newPassword;
	self.stack = newStack;
	self.account = newAccount;
	return self;
}

#pragma mark -
#pragma mark NSCoding Protocol Methods

- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeObject:userName forKey:@"UserName"]; 
	[coder encodeObject:password forKey:@"Password"]; 
	[coder encodeObject:stack forKey:@"Stack"]; 
	[coder encodeObject:account forKey:@"Account"]; 
}

- (id)initWithCoder:(NSCoder *)coder {
	if ((self = [super init])) {
		self.userName = [coder decodeObjectForKey:@"UserName"];
		self.password = [coder decodeObjectForKey:@"Password"];
		self.stack = [coder decodeObjectForKey:@"Stack"];
		self.account = [coder decodeObjectForKey:@"Account"];
	}
	return self;
}

@end
