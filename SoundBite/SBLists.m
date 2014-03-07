//
//  SBLists.m
//  SoundBite
//
//  Created by John Keyes on 12/11/2012.
//  Copyright 2012 John Keyes. All rights reserved.
//

#import "SBLists.h"


@implementation SBLists

@synthesize sbSoap;
@synthesize currentUser;

CWL_SYNTHESIZE_SINGLETON_FOR_CLASS(SBLists);

- (void)loadForUser:(User *)user withDelegate:(id)delegate {
    if (user == [self currentUser]) {
        NSLog(@"SBLists: user has not changed");
    } else {
		NSString *soapMessage = [NSString stringWithFormat:klistListsRequestTemplate, [user userName], [user password], [user account]];
        //NSLog(@"SBLists request: %@", soapMessage);
        self.currentUser = user;
        sbSoap = [[SBSoap2 alloc] init];
        [sbSoap request:user message:soapMessage urlTemplate:klistListsUrlTemplate delegate:delegate];
        NSLog(@"SBLists: initiated request");
    }
}

- (NSInteger)count {
	NSString *xpath = @"/Envelope/Body/listListsResponse/return/Data[IsDeleted='false']";
    NSArray *nodes = [sbSoap.doc nodesForXPath:xpath error:nil];
    NSLog(@"SBLists: %d lists", [nodes count]);
    //for (GDataXMLElement *node in nodes) {
    //    NSLog(@"%@", node.stringValue);
    //}
    return [nodes count];
}

- (NSString *)nameForRow:(NSInteger)row {
	NSString *xpathTemplate = @"/Envelope/Body/listListsResponse/return/Data[IsDeleted='false'][%d]/Name";
	NSString *xpath = [NSString stringWithFormat:xpathTemplate, row+1];
    //NSLog(@"xpath: %@", xpath);
    NSArray *nodes = [sbSoap.doc nodesForXPath:xpath error:nil];
    NSLog(@"SBLists: list=%@", [nodes[0] stringValue]);
    return [nodes[0] stringValue];
}

- (NSString *)internalIdForRow:(NSInteger)row {
	NSString *xpathTemplate = @"/Envelope/Body/listListsResponse/return/Data[IsDeleted='false'][%d]/InternalId";
	NSString *xpath = [NSString stringWithFormat:xpathTemplate, row+1];
    //NSLog(@"xpath: %@", xpath);
    NSArray *nodes = [sbSoap.doc nodesForXPath:xpath error:nil];
    NSLog(@"SBLists: InternalId=%@", [nodes[0] stringValue]);
    return [nodes[0] stringValue];
}

// This should start working in Engage 10.5.
- (NSString *)sizeForRow:(NSInteger)row {
	NSString *xpathTemplate = @"/Envelope/Body/listListsResponse/return/Data[IsDeleted='false'][%d]/Attributes[Name='size']/Value";
	NSString *xpath = [NSString stringWithFormat:xpathTemplate, row+1];
    //NSLog(@"xpath: %@", xpath);
    NSArray *nodes = [sbSoap.doc nodesForXPath:xpath error:nil];
    if (nodes.count >0) {
        if ([[nodes[0] stringValue] length] > 0) {
            NSLog(@"SBLists: Size for row %d is %@", row, [nodes[0] stringValue]);
            return [nodes[0] stringValue];
        } else {
            NSLog(@"SBLists: Size for row %d is empty", row);
            return @" - ";
        }
    }
    NSLog(@"SBLists: Size for row %d is missing", row);
    return @" - ";
}

- (NSString *)descriptionForRow:(NSInteger)row {
	NSString *xpathTemplate = @"/Envelope/Body/listListsResponse/return/Data[IsDeleted='false'][%d]/Description";
	NSString *xpath = [NSString stringWithFormat:xpathTemplate, row+1];
    //NSLog(@"xpath: %@", xpath);
    NSArray *nodes = [sbSoap.doc nodesForXPath:xpath error:nil];
    if (nodes.count >0) {
        if ([[nodes[0] stringValue] length] > 0) {
            NSLog(@"SBLists: Description for row %d is %@", row, [nodes[0] stringValue]);
            return [nodes[0] stringValue];
        } else {
            NSLog(@"SBLists: Description for row %d is empty", row);
            return @"";
        }
    }
    NSLog(@"SBLists: Description for row %d is missing", row);
    return @"";
}

@end
