//
//  Users.m
//  SoundBite
//
//  Created by John Keyes on 5/17/09.
//  Copyright 2012 John Keyes. All rights reserved.
//

#import "Users.h"

#define kFileName		@"SBarchive"
#define kArchiveName	@"SBUsers"

@implementation Users

- (NSString *)dataFilePath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = paths[0];
	return [documentsDirectory stringByAppendingPathComponent:kFileName];
}

- (void)load {
	NSLog(@"loading users");
	NSData *data = [[NSData alloc] initWithContentsOfFile:[self dataFilePath]];
	NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
	self.userArray = [unarchiver decodeObjectForKey:kArchiveName];
	[unarchiver finishDecoding];
	
	if (self.userArray == nil)
		self.userArray = [[NSMutableArray alloc] init];
}

- (NSUInteger)count {
	if (self.userArray == nil)
		return 0;
	else
		return [self.userArray count];
}

- (void)addNewUser {
	User *newUser = [[User alloc] init];
	[self.userArray addObject:newUser];
}

- (void)removeLastUser {
	[self.userArray removeLastObject];
}

- (void)save {
	NSLog(@"saving users");
	NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
	[archiver encodeObject:self.userArray forKey:kArchiveName];
	[archiver finishEncoding];
	[data writeToFile:[self dataFilePath] atomically:YES];
}


#pragma mark -
#pragma mark NSCoding Protocol Methods

- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeObject:self.userArray forKey:@"UserArray"];
}

- (id)initWithCoder:(NSCoder *)coder {
	if (self = [super init]) {
		self.userArray = [coder decodeObjectForKey:@"UserArray"];
	}
	return self;
}

@end
