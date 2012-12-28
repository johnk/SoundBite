//
//  User.m
//  SoundBite
//
//  Created by John Keyes on 5/13/09.
//  Copyright 2012 John Keyes. All rights reserved.
//

#import "User.h"


@implementation User

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
	[coder encodeObject:self.userName forKey:@"UserName"];
	[coder encodeObject:self.password forKey:@"Password"];
	[coder encodeObject:self.stack forKey:@"Stack"];
	[coder encodeObject:self.account forKey:@"Account"];
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
