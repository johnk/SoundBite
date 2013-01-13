//
//  SBSubCampaigns.m
//  SoundBite
//
//  Created by John Keyes on 12/11/2012.
//  Copyright 2012 John Keyes. All rights reserved.
//

#import "SBSubCampaigns.h"


@implementation SBSubCampaigns

@synthesize sbSoap;
@synthesize currentUser;
@synthesize currentCampaign;
@synthesize currentRow;

CWL_SYNTHESIZE_SINGLETON_FOR_CLASS(SBSubCampaigns);

- (void)loadForUser:user withDelegate:delegate {
    //if (user == [self currentUser]) {
    //    NSLog(@"SBSubCampaigns: user has not changed");
    //} else {
		// New way
//TODO: change this and the template to narrow by sub-campaign
		NSString *soapMessage = [NSString stringWithFormat:klistSubCampaignsRequestTemplate, [user userName], [user password], [user account]];
        self.currentUser = user;
        sbSoap = [[SBSoap2 alloc] init];
        [sbSoap request:user message:soapMessage urlTemplate:klistSubCampaignsUrlTemplate delegate:delegate];
		
		// Old way
        //self.currentUser = user;
        //sbSoap = [[SBSoap2 alloc] init];
        //[sbSoap request:user requestTemplate:klistSubCampaignsRequestTemplate urlTemplate:klistSubCampaignsUrlTemplate delegate:delegate];
        //NSLog(@"SBSubCampaigns: initiated request");
    //}
}

/* Xpath examples

Get all the sub names for a campaign
/Envelope/Body/listSubCampaignStatesResponse/return/Data[SubCampaign/Campaign/ExternalId='Default']/SubCampaign/ExternalId

Get the nth sub name for a campaign
/Envelope/Body/listSubCampaignStatesResponse/return/Data[SubCampaign/Campaign/ExternalId='baldemo'][2]/SubCampaign/ExternalId

Get the nth sub for a campaign
/Envelope/Body/listSubCampaignStatesResponse/return/Data[SubCampaign/Campaign/ExternalId='baldemo'][2]

Get all the subs for a campaign
/Envelope/Body/listSubCampaignStatesResponse/return/Data[SubCampaign/Campaign/ExternalId='baldemo']
	
Get all the Inbound sub names for a campaign
/Envelope/Body/listSubCampaignStatesResponse/return/Data[SubCampaign/Campaign/ExternalId='baldemo' and SubCampaign/Type='Inbound']/SubCampaign/ExternalId

 NSString *xpathTemplate = @"/Envelope/Body/listSubCampaignStatesResponse/return/Data[SubCampaign/Campaign/ExternalId='%@']/SubCampaign/ExternalId";
 
Get the nth pass for the mth sub-campaign of the campaign named 'demo'
/Envelope/Body/listSubCampaignStatesResponse/return/Data[SubCampaign/Campaign/ExternalId='demo'][m]/SubCampaign/Passes[n]

*/

- (NSInteger)count {
    NSString *xpathTemplate = @"/Envelope/Body/listSubCampaignStatesResponse/return/Data[SubCampaign/Campaign/ExternalId='%@']";
    NSString *xpath = [NSString stringWithFormat:xpathTemplate, self.currentCampaign];
    NSLog(@"SBSubCampaigns xpath: %@", xpath);
    NSArray *nodes = [sbSoap.doc nodesForXPath:xpath error:nil];
    NSLog(@"SBSubCampaigns: %d subcampaigns", [nodes count]);
    /*
     for (GDataXMLElement *node in nodes) {
     NSLog(@"%@", node.stringValue);
     }
     */
    return [nodes count];
}

- (NSInteger)countPassesForSubCampaignInRow:(NSInteger)row {
    NSString *xpathTemplate = @"/Envelope/Body/listSubCampaignStatesResponse/return/Data[SubCampaign/Campaign/ExternalId='%@'][%d]/SubCampaign/Passes";
    NSString *xpath = [NSString stringWithFormat:xpathTemplate, self.currentCampaign, row+1];
    NSLog(@"SBSubCampaigns xpath: %@", xpath);
    NSArray *nodes = [sbSoap.doc nodesForXPath:xpath error:nil];
    NSLog(@"SBSubCampaigns: %d passes", [nodes count]);
    return [nodes count];
}

- (NSString *)nameForRow:(NSInteger)row {
 	NSString *xpath = [NSString stringWithFormat:@"/Envelope/Body/listSubCampaignStatesResponse/return/Data[SubCampaign/Campaign/ExternalId='%@'][%d]/SubCampaign/ExternalId", self.currentCampaign, row+1];
    NSLog(@"xpath: %@", xpath);
    NSArray *nodes = [sbSoap.doc nodesForXPath:xpath error:nil];
    NSLog(@"SBSubCampaigns: sub-campaign=%@", [nodes[0] stringValue]);
    return [nodes[0] stringValue];
}

- (NSString *)statusForRow:(NSInteger)row {
    NSString *xpathTemplate = @"/Envelope/Body/listSubCampaignStatesResponse/return/Data[SubCampaign/Campaign/ExternalId='%@'][%d]/State";			
    NSString *xpath = [NSString stringWithFormat:xpathTemplate, self.currentCampaign, row+1];
    NSArray *nodes = [sbSoap.doc nodesForXPath:xpath error:nil];
    return [nodes[0] stringValue];
}

- (NSString *)filteredCountForRow:(NSInteger)row {
    NSString *xpathTemplate = @"/Envelope/Body/listSubCampaignStatesResponse/return/Data[SubCampaign/Campaign/ExternalId='%@'][%d]/Attributes[Name='filteredCount']/Value";
    NSString *xpath = [NSString stringWithFormat:xpathTemplate, self.currentCampaign, row+1];
    NSArray *nodes = [sbSoap.doc nodesForXPath:xpath error:nil];
    return [nodes[0] stringValue];
}

- (NSString *)attemptedCountForRow:(NSInteger)row {
    NSString *xpathTemplate = @"/Envelope/Body/listSubCampaignStatesResponse/return/Data[SubCampaign/Campaign/ExternalId='%@'][%d]/Attributes[Name='attemptedCount']/Value";			
    NSString *xpath = [NSString stringWithFormat:xpathTemplate, self.currentCampaign, row+1];
    NSArray *nodes = [sbSoap.doc nodesForXPath:xpath error:nil];
    return [nodes[0] stringValue];
}

- (NSString *)notAttemptedCountForRow:(NSInteger)row {
    NSString *xpathTemplate = @"/Envelope/Body/listSubCampaignStatesResponse/return/Data[SubCampaign/Campaign/ExternalId='%@'][%d]/Attributes[Name='notAttemptedCount']/Value";			
    NSString *xpath = [NSString stringWithFormat:xpathTemplate, self.currentCampaign, row+1];
    NSArray *nodes = [sbSoap.doc nodesForXPath:xpath error:nil];
    return [nodes[0] stringValue];
}

- (NSString *)pendingCountForRow:(NSInteger)row {
    NSString *xpathTemplate = @"/Envelope/Body/listSubCampaignStatesResponse/return/Data[SubCampaign/Campaign/ExternalId='%@'][%d]/Attributes[Name='pendingCount']/Value";			
    NSString *xpath = [NSString stringWithFormat:xpathTemplate, self.currentCampaign, row+1];
    NSArray *nodes = [sbSoap.doc nodesForXPath:xpath error:nil];
    return [nodes[0] stringValue];
}

- (NSString *)deliveredCountForRow:(NSInteger)row {
    NSString *xpathTemplate = @"/Envelope/Body/listSubCampaignStatesResponse/return/Data[SubCampaign/Campaign/ExternalId='%@'][%d]/Attributes[Name='deliveredCount']/Value";			
    NSString *xpath = [NSString stringWithFormat:xpathTemplate, self.currentCampaign, row+1];
    NSArray *nodes = [sbSoap.doc nodesForXPath:xpath error:nil];
    return [nodes[0] stringValue];
}

- (NSString *)failedCountForRow:(NSInteger)row {
    NSString *xpathTemplate = @"/Envelope/Body/listSubCampaignStatesResponse/return/Data[SubCampaign/Campaign/ExternalId='%@'][%d]/Attributes[Name='failedCount']/Value";			
    NSString *xpath = [NSString stringWithFormat:xpathTemplate, self.currentCampaign, row+1];
    NSArray *nodes = [sbSoap.doc nodesForXPath:xpath error:nil];
    return [nodes[0] stringValue];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"current user: %@", self.currentUser];
}

@end
