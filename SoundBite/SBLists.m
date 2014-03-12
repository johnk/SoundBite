//
//  SBLists.m
//  SoundBite
//
//  Created by John Keyes on 12/11/2012.
//  Copyright 2012 John Keyes. All rights reserved.
//

#import "SBLists.h"


@implementation SBLists

CWL_SYNTHESIZE_SINGLETON_FOR_CLASS(SBLists);

- (void)loadForUser:(User *)user withDelegate:(id)delegate {
    if (user == [self currentUser]) {
        NSLog(@"SBLists: user has not changed");
    } else {
        self.currentUser = user;
        self.sbSoap = [[SBSoap2 alloc] init];
        self.sbSoap.currentUser = user;
        
        NSURL *url = [SBSoap2 sbSoapCreateURL:user.stack service:kContactManagementService];
        NSString *soapBody = [NSString stringWithFormat:klistLists, user.account];
        NSString *request = [SBSoap2 sbSoapCreateRequest:user soapBody:soapBody];
        
        [self.sbSoap sbSoapSendRequest:url request:request delegate:delegate];
        
        NSLog(@"SBLists: initiated request");
    }
}

- (NSInteger)count {
	NSString *xpath = @"/Envelope/Body/listListsResponse/return/data[isDeleted='false']";
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    NSLog(@"SBLists: %d lists", [nodes count]);
    //for (GDataXMLElement *node in nodes) {
    //    NSLog(@"%@", node.stringValue);
    //}
    return [nodes count];
}

- (NSString *)nameForRow:(NSInteger)row {
	NSString *xpathTemplate = @"/Envelope/Body/listListsResponse/return/data[isDeleted='false'][%d]/name";
	NSString *xpath = [NSString stringWithFormat:xpathTemplate, row+1];
    //NSLog(@"xpath: %@", xpath);
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    NSLog(@"SBLists: list=%@", [nodes[0] stringValue]);
    return [nodes[0] stringValue];
}

- (NSString *)internalIdForRow:(NSInteger)row {
	NSString *xpathTemplate = @"/Envelope/Body/listListsResponse/return/data[isDeleted='false'][%d]/internalId";
	NSString *xpath = [NSString stringWithFormat:xpathTemplate, row+1];
    //NSLog(@"xpath: %@", xpath);
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    NSLog(@"SBLists: InternalId=%@", [nodes[0] stringValue]);
    return [nodes[0] stringValue];
}

// This should start working in Engage 10.5.
- (NSString *)sizeForRow:(NSInteger)row {
	NSString *xpathTemplate = @"/Envelope/Body/listListsResponse/return/data[isDeleted='false'][%d]/attributes[name='size']/value";
	NSString *xpath = [NSString stringWithFormat:xpathTemplate, row+1];
    //NSLog(@"xpath: %@", xpath);
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
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
	NSString *xpathTemplate = @"/Envelope/Body/listListsResponse/return/data[isDeleted='false'][%d]/description";
	NSString *xpath = [NSString stringWithFormat:xpathTemplate, row+1];
    //NSLog(@"xpath: %@", xpath);
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
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
