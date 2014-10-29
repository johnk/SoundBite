//
//  SBStacks.m
//  SoundBite
//
//  Created by John Keyes on 3/29/14.
//  Copyright (c) 2014 John Keyes. All rights reserved.
//

#import "SBStacks.h"

@implementation SBStacks

CWL_SYNTHESIZE_SINGLETON_FOR_CLASS(SBStacks);

- (NSString *)sbStackURL {
    if (!_sbStackURL) {
        [self initStacks];
    }
    return _sbStackURL;
}

- (NSArray *)sbStacks {
    if (!_sbStacks) {
        [self initStacks];
    }
    return _sbStacks;
}

- (NSInteger)count {
    NSLog(@"stacks count %lu", (unsigned long)[self.sbStacks count]);
    return [self.sbStacks count];
}

- (void)initStacks {
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = paths[0];
    // get the path to the plist file
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"EngageProperties.plist"];
    
    // check to see if plist exists in documents
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        // if not in documents, get property list from main bundle
        plistPath = [[NSBundle mainBundle] pathForResource:@"EngageProperties" ofType:@"plist"];
    }
    
    // read property list into memory as an NSData object
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSError *error;
    NSPropertyListFormat format;
    
    // convert static property list into dictionary object
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization propertyListWithData:plistXML options:NSPropertyListMutableContainersAndLeaves format:&format error:&error];
    if (!temp) {
        NSLog(@"Error reading plist: %@, format: %lu", error.localizedDescription, format);
    }
    
    // assign values
    self.sbStackURL = temp[@"stackURL"];
    self.sbStacks = [NSMutableArray arrayWithArray:temp[@"stacks"]];
}

@end
