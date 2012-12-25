//
//  Users.m
//  SoundBite
//
//  Created by John Keyes on 5/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Users.h"

#define kFileName		@"SBarchive"
#define kArchiveName	@"SBUsers"

@implementation Users

@synthesize userArray;

- (NSString *)dataFilePath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = paths[0];
	return [documentsDirectory stringByAppendingPathComponent:kFileName];
}

- (void)load {
	// load list of users from disk
	/*
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSArray * array = [prefs arrayForKey:@"userArrayKey"];
	NSLog(@"%d", [array count]);
	self.userArray = (NSMutableArray *)array;
	[array release];
	*/
	
	/*
	self.userArray = [[NSMutableArray alloc] init];
	User *user1 = [[User alloc] initWithUserOnStack:@"service4" name:@"jkeyes-ws@soundbite.com" password:@"wstest1" account:@"3000009744"];
	[userArray addObject:user1];
	User *user2 = [[User alloc] initWithUserOnStack:@"service4" name:@"fred@soundbite.com" password:@"wstest1" account:@"3000009745"];
	[userArray addObject:user2];
	User *user3 = [[User alloc] initWithUserOnStack:@"service4" name:@"barney@soundbite.com" password:@"wstest1" account:@"3000009746"];
	[userArray addObject:user3];
	*/
	
	
	NSLog(@"loading users");
	NSData *data = [[NSData alloc] initWithContentsOfFile:[self dataFilePath]];
	NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
	self.userArray = [unarchiver decodeObjectForKey:kArchiveName];
	[unarchiver finishDecoding];
	
	if (userArray == nil)
		userArray = [[NSMutableArray alloc] init];
}

- (NSUInteger)count {
	if (self.userArray == nil)
		return 0;
	else
		return [self.userArray count];
}

- (void)addNewUser {
	User *newUser = [[User alloc] init];
	[userArray addObject:newUser];
}

- (void)save {
	// save list of users to disk
	/*
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	[prefs setObject:userArray forKey:@"userArrayKey"];
	*/
	NSLog(@"saving users");
	NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
	[archiver encodeObject:self.userArray forKey:kArchiveName];
	[archiver finishEncoding];
	//BOOL success = [data writeToFile:[self dataFilePath] atomically:YES];
	[data writeToFile:[self dataFilePath] atomically:YES];
}


#pragma mark -
#pragma mark NSCoding Protocol Methods

- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeObject:userArray forKey:@"UserArray"]; 
}

- (id)initWithCoder:(NSCoder *)coder {
	if (self = [super init]) {
		self.userArray = [coder decodeObjectForKey:@"UserArray"];
	}
	return self;
}

@end
