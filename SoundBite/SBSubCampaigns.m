//
//  SBSubCampaigns.m
//  SoundBite
//
//  Created by John Keyes on 12/11/2012.
//  Copyright 2012 John Keyes. All rights reserved.
//

#import "SBSubCampaigns.h"


@implementation SBSubCampaigns

CWL_SYNTHESIZE_SINGLETON_FOR_CLASS(SBSubCampaigns);

- (void)loadForUser:(User *)user withDelegate:(id)delegate {
    
    //if (user == [self currentUser]) {
    //    NSLog(@"SBSuƒnslogbCampaigns: user has not changed");
    //} else {

    //TODO: change this and the template to narrow by sub-campaign

    self.currentUser = user;
    self.sbSoap = [[SBSoap2 alloc] init];
    self.sbSoap.currentUser = user;

    NSURL *url = [SBSoap2 sbSoapCreateURL:user.stack service:kCampaignManagementService];
    NSString *soapBody = [NSString stringWithFormat:klistSubCampaignStates, user.account];
    NSString *request = [SBSoap2 sbSoapCreateRequest:user soapBody:soapBody];

    [self.sbSoap sbSoapSendRequest:url request:request delegate:delegate];
    
    NSLog(@"SBSubCampaigns: initiated request");
}

- (void)changeScStatus:(NSString *)newStatus {
    // newStatus is assumed to be Running, Paused, or Stopping
    
    NSLog(@"SBSubCampaigns changeScStatus: requesting status change to %@", newStatus);

    NSURL *url = [SBSoap2 sbSoapCreateURL:self.currentUser.stack service:kCampaignManagementService];
    NSString *soapBody = [NSString stringWithFormat:kchangeSubCampaignState, self.currentInternalId, newStatus];
    NSString *request = [SBSoap2 sbSoapCreateRequest:self.currentUser soapBody:soapBody];
    
    // We don't really need the dataIsReady method for this call, so we'll just pass
    // self as the delegate and nothing will get called.
    [self.sbSoap sbSoapSendRequest:url request:request delegate:self];
}

/* Xpath examples

Get all the sub names for a campaign
/Envelope/Body/listSubCampaignStatesResponse/return/data[subCampaign/campaign/externalId='Default']/subCampaign/externalId

Get the nth sub name for a campaign
/Envelope/Body/listSubCampaignStatesResponse/return/data[subCampaign/campaign/externalId='baldemo'][2]/subCampaign/externalId

Get the nth sub for a campaign
/Envelope/Body/listSubCampaignStatesResponse/return/data[subCampaign/campaign/externalId='baldemo'][2]

Get all the subs for a campaign
/Envelope/Body/listSubCampaignStatesResponse/return/data[subCampaign/campaign/externalId='baldemo']
	
Get all the Inbound sub names for a campaign
/Envelope/Body/listSubCampaignStatesResponse/return/data[subCampaign/campaign/externalId='baldemo' and SubCampaign/Type='Inbound']/subCampaign/externalId

 NSString *xpathTemplate = @"/Envelope/Body/listSubCampaignStatesResponse/return/data[subCampaign/campaign/externalId='%@']/subCampaign/externalId";
 
Get the nth pass for the mth sub-campaign of the campaign named 'demo'
/Envelope/Body/listSubCampaignStatesResponse/return/data[subCampaign/campaign/externalId='demo'][m]/subCampaign/passes[n]

*/

- (NSInteger)count {
    NSString *xpathTemplate = @"/Envelope/Body/listSubCampaignStatesResponse/return/data[subCampaign/campaign/externalId='%@']";
    NSString *xpath = [NSString stringWithFormat:xpathTemplate, self.currentCampaign];
    NSLog(@"SBSubCampaigns xpath: %@", xpath);
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    NSLog(@"SBSubCampaigns: %lu subcampaigns", (unsigned long)[nodes count]);
    /*
     for (GDataXMLElement *node in nodes) {
     NSLog(@"%@", node.stringValue);
     }
     */
    return [nodes count];
}

- (NSString *)nameForRow:(NSInteger)row {
 	NSString *xpath = [NSString stringWithFormat:@"/Envelope/Body/listSubCampaignStatesResponse/return/data[subCampaign/campaign/externalId='%@'][%lu]/subCampaign/externalId", self.currentCampaign, (unsigned long)row+1];
    NSLog(@"xpath: %@", xpath);
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    NSLog(@"SBSubCampaigns: sub-campaign=%@", [nodes[0] stringValue]);
    return [nodes[0] stringValue];
}

- (NSString *)internalIdForRow:(NSInteger)row {
 	NSString *xpath = [NSString stringWithFormat:@"/Envelope/Body/listSubCampaignStatesResponse/return/data[subCampaign/campaign/externalId='%@'][%lu]/subCampaign/internalId", self.currentCampaign, (unsigned long)row+1];
    NSLog(@"xpath: %@", xpath);
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    NSLog(@"SBSubCampaigns: sub-campaign internalId=%@", [nodes[0] stringValue]);
    return [nodes[0] stringValue];
}

- (NSString *)statusForRow:(NSInteger)row {
    NSString *xpathTemplate = @"/Envelope/Body/listSubCampaignStatesResponse/return/data[subCampaign/campaign/externalId='%@'][%d]/state";
    NSString *xpath = [NSString stringWithFormat:xpathTemplate, self.currentCampaign, row+1];
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    return [nodes[0] stringValue];
}

/*
- (NSString *)filteredCountForRow:(NSInteger)row {
    NSString *xpathTemplate = @"/Envelope/Body/listSubCampaignStatesResponse/return/data[subCampaign/campaign/externalId='%@'][%d]/attributes[Name='filteredCount']/value";
    NSString *xpath = [NSString stringWithFormat:xpathTemplate, self.currentCampaign, row+1];
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    return [nodes[0] stringValue];
}
*/

- (NSString *)attemptedCountForRow:(NSInteger)row {
    NSString *xpathTemplate = @"/Envelope/Body/listSubCampaignStatesResponse/return/data[subCampaign/campaign/externalId='%@'][%d]/attributes[name='attemptedCount']/value";
    NSString *xpath = [NSString stringWithFormat:xpathTemplate, self.currentCampaign, row+1];
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    return [nodes[0] stringValue];
}

/*
- (NSString *)notAttemptedCountForRow:(NSInteger)row {
    NSString *xpathTemplate = @"/Envelope/Body/listSubCampaignStatesResponse/return/data[subCampaign/campaign/externalId='%@'][%d]/attributes[Name='notAttemptedCount']/value";			
    NSString *xpath = [NSString stringWithFormat:xpathTemplate, self.currentCampaign, row+1];
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    return [nodes[0] stringValue];
}

- (NSString *)pendingCountForRow:(NSInteger)row {
    NSString *xpathTemplate = @"/Envelope/Body/listSubCampaignStatesResponse/return/data[subCampaign/campaign/externalId='%@'][%d]/attributes[Name='pendingCount']/value";			
    NSString *xpath = [NSString stringWithFormat:xpathTemplate, self.currentCampaign, row+1];
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    return [nodes[0] stringValue];
}
*/

- (NSString *)deliveredCountForRow:(NSInteger)row {
    NSString *xpathTemplate = @"/Envelope/Body/listSubCampaignStatesResponse/return/data[subCampaign/campaign/externalId='%@'][%d]/attributes[name='deliveredCount']/value";
    NSString *xpath = [NSString stringWithFormat:xpathTemplate, self.currentCampaign, row+1];
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    return [nodes[0] stringValue];
}

/*
- (NSString *)failedCountForRow:(NSInteger)row {
    NSString *xpathTemplate = @"/Envelope/Body/listSubCampaignStatesResponse/return/data[subCampaign/campaign/externalId='%@'][%d]/attributes[Name='failedCount']/value";			
    NSString *xpath = [NSString stringWithFormat:xpathTemplate, self.currentCampaign, row+1];
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    return [nodes[0] stringValue];
}
*/

// Passes
//

- (NSInteger)countPassesForSub:(NSInteger)row {
    NSString *xpathTemplate = @"/Envelope/Body/listSubCampaignStatesResponse/return/data[subCampaign/campaign/externalId='%@'][%d]/subCampaign/passes";
    NSString *xpath = [NSString stringWithFormat:xpathTemplate, self.currentCampaign, row+1];
    NSLog(@"SBSubCampaigns xpath: %@", xpath);
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    NSLog(@"SBSubCampaigns: %lu passes", (unsigned long)[nodes count]);
    return [nodes count];
}

- (NSString *)passNameForSub:(NSInteger)row pass:(NSInteger)pass {
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);

    NSString *xpathTemplate = @"/Envelope/Body/listSubCampaignStatesResponse/return/data[subCampaign/campaign/externalId='%@'][%d]/subCampaign/passes[%d]/name";
    NSString *xpath = [NSString stringWithFormat:xpathTemplate, self.currentCampaign, row+1, pass+1];
    NSLog(@"xpath: %@", xpath);
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    NSLog(@"pass name: %@", [nodes[0] stringValue]);
    return [nodes[0] stringValue];
}

// Returns an integer representing channel type
- (NSInteger)passChannelForSub:(NSInteger)row pass:(NSInteger)pass {
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);

    NSString *xpathTemplate = @"/Envelope/Body/listSubCampaignStatesResponse/return/data[subCampaign/campaign/externalId='%@'][%d]/subCampaign/passes[%d]/channel";

    NSString *xpath = [NSString stringWithFormat:xpathTemplate, self.currentCampaign, row+1, pass+1];
    NSLog(@"xpath: %@", xpath);
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    NSString *channelType = [nodes[0] stringValue];
    NSLog(@"pass channel: %ld", (long)channelType.integerValue);
    return channelType.integerValue;
}

- (NSString *)passStatusForSub:(NSInteger)row pass:(NSInteger)pass {
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
    NSString *xpathTemplate = @"/Envelope/Body/listSubCampaignStatesResponse/return/data[subCampaign/campaign/externalId='%@'][%d]/passStates[%d]/state";
    NSString *xpath = [NSString stringWithFormat:xpathTemplate, self.currentCampaign, row+1, pass+1];
    NSLog(@"xpath: %@", xpath);
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];
    NSLog(@"pass status: %@", [nodes[0] stringValue]);
    return [nodes[0] stringValue];
}

- (NSDictionary *)getAttributesForSub:(NSInteger)row {
	//  /Envelope/Body/listSubCampaignStatesResponse/return/data[subCampaign/campaign/externalId='%@'][%d]/attributes[Name='pendingCount']/value	
    NSString *xpathTemplate = @"/Envelope/Body/listSubCampaignStatesResponse/return/data[subCampaign/campaign/externalId='%@'][%d]/attributes";
    NSString *xpath = [NSString stringWithFormat:xpathTemplate, self.currentCampaign, row+1];
    NSLog(@"xpath: %@", xpath);
    return [self getAttributesForXPath:xpath];
}

// Return a dictionary of attributes for the pass
- (NSDictionary *)getAttributesForSub:(NSInteger)row pass:(NSInteger)pass {
    NSString *xpathTemplate = @"/Envelope/Body/listSubCampaignStatesResponse/return/data[subCampaign/campaign/externalId='%@'][%d]/passStates[%d]/attributes";
    NSString *xpath = [NSString stringWithFormat:xpathTemplate, self.currentCampaign, row+1, pass+1];
    NSLog(@"xpath: %@", xpath); 
    return [self getAttributesForXPath:xpath];
}

- (NSDictionary *)getAttributesForXPath:(NSString *)xpath {
	// /Envelope/Body/listSubCampaignStatesResponse/return/data[subCampaign/campaign/externalId='multichannel'][1]/PassStates[1]/attributes
	// <Attributes>
    //     <Name>attemptedCount</Name>
    //     <Value>3611</value>
    // </attributes>
	//
	// See example code: http://www.raywenderlich.com/725/how-to-read-and-write-xml-documents-with-gdataxml

    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSArray *nodes = [self.sbSoap.doc nodesForXPath:xpath error:nil];

	NSLog(@"Found %lu nodes:", (unsigned long)[nodes count]);
	for (GDataXMLElement *node in nodes) {
		NSLog(@"%@", node.stringValue);
		
		NSString *name;
		NSString *value;

		// Name
		NSArray *names = [node elementsForName:@"name"];
		if (names.count > 0) {
			GDataXMLElement *firstName = (GDataXMLElement *) names[0];
			name = firstName.stringValue;
		} else continue;

		// Value
		NSArray *values = [node elementsForName:@"value"];
		if (values.count > 0) {
			GDataXMLElement *firstValue = (GDataXMLElement *) values[0];
			value = firstValue.stringValue;
		} else continue;
		
		dict[name] = value;
	}   
    return dict;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"current user: %@", self.currentUser];
}

@end
