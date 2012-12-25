//
//  Users.h
//  SoundBite
//
//  Created by John Keyes on 5/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"


@interface Users : NSObject <NSCoding> {
	NSMutableArray *userArray;
}

@property (nonatomic, strong) NSMutableArray *userArray;

- (void)load;
- (NSUInteger)count;
- (void)addNewUser;
- (void)save;
- (void)encodeWithCoder:(NSCoder *)coder;
- (id)initWithCoder:(NSCoder *)coder;

@end
