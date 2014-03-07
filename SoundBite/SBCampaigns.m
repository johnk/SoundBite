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

- (void)loadForUser:(User *)user withDelegate:(id)delegate {
    if (user == [self currentUser]) {
        NSLog(@"SBCampaigns: user has not changed");
    } else {
        self.currentUser = user;
        self.sbSoap = [[SBSoap2 alloc] init];
        self.sbSoap.currentUser = user;
        
        NSURL *url = [SBSoap2 sbSoapCreateURL:(user.stack) service:kCampaignManagementService];
        NSString *soapBody = [NSString stringWithFormat:klistCampaigns, user.account];
        NSString *request = [SBSoap2 sbSoapCreateRequest:user soapBody:soapBody];
        
        [self.sbSoap sbSoapSendRequest:url request:request delegate:delegate];
    
        NSLog(@"SBCampaigns: initiated request");
    }
}

- (NSInteger)count {

    //NSString *xpath = @"//Data/ExternalId";			
	//NSString *xpath = @"/Envelope/Body/listCampaignsResponse/return/Data[@type='n1:Campaign']";

	NSString *xpath = @"/Envelope/Body/listCampaignsResponse/return/data";
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    
    NSLog(@"SBCampaigns: %lu campaigns", (unsigned long)[nodes count]);

    
    for (GDataXMLElement *node in nodes) {
        NSLog(@"%@", node.stringValue);
    } 
    
    
    return [nodes count];
}

- (NSString *)nameForRow:(NSInteger)row {

	// /Envelope/Body/listCampaignsResponse/return/Data[<row>]/ExternalId
	
	NSString *xpath = [NSString stringWithFormat:@"/Envelope/Body/listCampaignsResponse/return/data[%d]/externalId", row+1];
    NSLog(@"xpath: %@", xpath);
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    NSLog(@"SBCampaigns: campaign=%@", [nodes[0] stringValue]);
    return [nodes[0] stringValue];
}

- (NSString *)startDateForRow:(NSInteger)row {
    NSString *xpathTemplate = @"/Envelope/Body/listCampaignsResponse/return/data[%d]/attributes[name='startDate']/value";
    NSString *xpath = [NSString stringWithFormat:xpathTemplate, row+1];
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    return [nodes[0] stringValue];
    }

- (NSString *)endDateForRow:(NSInteger)row {
    NSString *xpathTemplate = @"/Envelope/Body/listCampaignsResponse/return/data[%d]/attributes[name='endDate']/value";
    NSString *xpath = [NSString stringWithFormat:xpathTemplate, row+1];
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    return [nodes[0] stringValue];
}

@end
