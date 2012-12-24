//
//  SBList.m
//  SoundBite
//
//  Created by John Keyes on 12/11/2012.
//  Copyright 2012 John Keyes. All rights reserved.
//

#import "SBList.h"

@implementation SBList


CWL_SYNTHESIZE_SINGLETON_FOR_CLASS(SBList);

- (void)loadForUser:user list:listInternalId withDelegate:delegate {
    if (listInternalId == [self currentListInternalId]) {
        NSLog(@"SBList: list has not changed");
    } else {
		NSString *soapMessage = [NSString stringWithFormat:kshowListRequestTemplate, [user userName], [user password], listInternalId];
        self.currentListInternalId = listInternalId;
        self.sbSoap = [[SBSoap2 alloc] init];
        [self.sbSoap request:user message:soapMessage urlTemplate:kshowListUrlTemplate delegate:delegate];
        NSLog(@"SBList: initiated request");
    }
}

// Shouldn't really need this method; always just the one we asked for.
- (NSInteger)count {
	NSString *xpath = @"/Envelope/Body/listListsResponse/return/Data";
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    NSLog(@"SBList: %d list (should be just one)", [nodes count]);
    return [nodes count];
}

- (NSString *)name {
	NSString *xpath = @"/Envelope/Body/showListResponse/return/Data[1]/Name";
    NSLog(@"xpath: %@", xpath);
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    NSLog(@"SBList: list=%@", [nodes[0] stringValue]);
    return [nodes[0] stringValue];
}

- (NSString *)size {
	NSString *xpath = @"/Envelope/Body/showListResponse/return/Data[1]/Attributes[Name='size']/Value";
    NSLog(@"xpath: %@", xpath);
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    NSLog(@"SBList: size=%@", [nodes[0] stringValue]);
    return [nodes[0] stringValue];
}

- (NSString *)useCount {
	NSString *xpath = @"/Envelope/Body/showListResponse/return/Data[1]/Attributes[Name='useCount']/Value";
    NSLog(@"xpath: %@", xpath);
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    NSLog(@"SBList: description=%@", [nodes[0] stringValue]);
    return [nodes[0] stringValue];
}

@end
