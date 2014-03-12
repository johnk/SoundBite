//
//  SBScripts.m
//  SoundBite
//
//  Created by John Keyes on 12/11/2012.
//  Copyright 2012 John Keyes. All rights reserved.
//

#import "SBScripts.h"


@implementation SBScripts

CWL_SYNTHESIZE_SINGLETON_FOR_CLASS(SBScripts);

- (void)loadForUser:(User *)user withDelegate:(id)delegate {
    if (user == [self currentUser]) {
        NSLog(@"SBScripts: user has not changed");
    } else {
        self.currentUser = user;
        self.sbSoap = [[SBSoap2 alloc] init];
        self.sbSoap.currentUser = user;
        
        NSURL *url = [SBSoap2 sbSoapCreateURL:user.stack service:kCampaignManagementService];
        NSString *soapBody = [NSString stringWithFormat:klistScripts, user.account];
        NSString *request = [SBSoap2 sbSoapCreateRequest:user soapBody:soapBody];
        
        [self.sbSoap sbSoapSendRequest:url request:request delegate:delegate];

        NSLog(@"SBScripts: initiated request");
    }
}

- (NSInteger)count {
	NSString *xpath = @"/Envelope/Body/listScriptsResponse/return/data";
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    NSLog(@"SBScripts: %d scripts", [nodes count]);
    //for (GDataXMLElement *node in nodes) {
    //    NSLog(@"%@", node.stringValue);
    //}
    return [nodes count];
}

- (NSString *)nameForRow:(NSInteger)row {
	NSString *xpathTemplate = @"/Envelope/Body/listScriptsResponse/return/data[%d]/externalId";
	NSString *xpath = [NSString stringWithFormat:xpathTemplate, row+1];
    //NSLog(@"xpath: %@", xpath);
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    NSLog(@"SBScripts: script=%@", [nodes[0] stringValue]);
    return [nodes[0] stringValue];
}

// ??? missing from response
- (NSString *)versionForRow:(NSInteger)row {
	NSString *xpathTemplate = @"/Envelope/Body/listScriptsResponse/return/data[%d]/version";
	NSString *xpath = [NSString stringWithFormat:xpathTemplate, row+1];
    //NSLog(@"xpath: %@", xpath);
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    if (nodes.count >0) {
        if ([[nodes[0] stringValue] length] > 0) {
            NSLog(@"SBScripts: Version for row %d is %@", row, [nodes[0] stringValue]);
            return [nodes[0] stringValue];
        } else {
            NSLog(@"SBScripts: Version for row %d is empty", row);
            return @" - ";
        }
    }
    NSLog(@"SBScripts: Version for row %d is missing", row);
    return @" - ";
}

// ??? missing from response
- (NSString *)descriptionForRow:(NSInteger)row {
	NSString *xpathTemplate = @"/Envelope/Body/listScriptsResponse/return/data[%d]/description";
	NSString *xpath = [NSString stringWithFormat:xpathTemplate, row+1];
    //NSLog(@"xpath: %@", xpath);
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    if (nodes.count >0) {
        if ([[nodes[0] stringValue] length] > 0) {
            NSLog(@"SBScripts: Description for row %d is %@", row, [nodes[0] stringValue]);
            return [nodes[0] stringValue];
        } else {
            NSLog(@"SBScripts: Description for row %d is empty", row);
            return @"";
        }
    }
    NSLog(@"SBScripts: Description for row %d is missing", row);
    return @"";
}

@end
