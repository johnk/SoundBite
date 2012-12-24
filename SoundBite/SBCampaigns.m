//
//  SBCampaigns.m
//  SoundBite
//
//  Created by John Keyes on 2/26/11.
//  Copyright 2011 johnkeyes. All rights reserved.
//

#import "SBCampaigns.h"


@implementation SBCampaigns


CWL_SYNTHESIZE_SINGLETON_FOR_CLASS(SBCampaigns);

- (void)loadForUser:user withDelegate:delegate {
    if (user == [self currentUser]) {
        NSLog(@"SBCampaigns: user has not changed");
    } else {
        self.currentUser = user;
        self.sbSoap = [[SBSoap2 alloc] init];
        [self.sbSoap request:user requestTemplate:klistCampaignsRequestTemplate urlTemplate:klistCampaignsUrlTemplate delegate:delegate];
        NSLog(@"SBCampaigns: initiated request");
    }
}

- (NSInteger)count {

    //NSString *xpath = @"//Data/ExternalId";			
	//NSString *xpath = @"/Envelope/Body/listCampaignsResponse/return/Data[@type='n1:Campaign']";

	NSString *xpath = @"/Envelope/Body/listCampaignsResponse/return/Data";
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    
    NSLog(@"SBCampaigns: %d campaigns", [nodes count]);

    
    for (GDataXMLElement *node in nodes) {
        NSLog(@"%@", node.stringValue);
    } 
    
    
    return [nodes count];
}

- (NSString *)nameForRow:(NSInteger)row {

	// /Envelope/Body/listCampaignsResponse/return/Data[<row>]/ExternalId
	
	NSString *xpath = [NSString stringWithFormat:@"/Envelope/Body/listCampaignsResponse/return/Data[%d]/ExternalId", row+1];
    NSLog(@"xpath: %@", xpath);
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    NSLog(@"SBCampaigns: campaign=%@", [nodes[0] stringValue]);
    return [nodes[0] stringValue];
}

- (NSString *)startDateForRow:(NSInteger)row {
    NSString *xpathTemplate = @"/Envelope/Body/listCampaignsResponse/return/Data[%d]/Attributes[Name='startDate']/Value";			
    NSString *xpath = [NSString stringWithFormat:xpathTemplate, row+1];
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    return [nodes[0] stringValue];
    }

- (NSString *)endDateForRow:(NSInteger)row {
    NSString *xpathTemplate = @"/Envelope/Body/listCampaignsResponse/return/Data[%d]/Attributes[Name='endDate']/Value";			
    NSString *xpath = [NSString stringWithFormat:xpathTemplate, row+1];
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    return [nodes[0] stringValue];
}

@end
