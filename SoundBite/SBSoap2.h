//
//  SBSoap2.h
//  SoundBite
//
//  Created by John Keyes on 6/5/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "GDataXMLNode.h"



#define	klistCampaignsRequestTemplate		@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:wsa='http://schemas.xmlsoap.org/ws/2004/08/addressing' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:wsse='http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd' xmlns:wsu='http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/' xmlns:xsd='http://www.w3.org/2001/XMLSchema'><soap:Header><wsa:Action></wsa:Action><wsa:ReplyTo><wsa:Address>http://schemas.xmlsoap.org/ws/2004/08/addressing/role/anonymous</wsa:Address></wsa:ReplyTo><wsa:To>https://service3.soundbite.com/SOAPAPI/CampaignManagementService</wsa:To><wsse:Security soap:mustUnderstand='1'><wsse:UsernameToken xmlns:wsu='http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd'><wsse:Username>%@</wsse:Username><wsse:Password Type='http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText'>%@</wsse:Password></wsse:UsernameToken></wsse:Security></soap:Header><soap:Body><listCampaigns xmlns='http://www.soundbite.com/SOAPAPI'><arg1 xmlns=''><CreatedBy xmlns='java:COM.soundbite.service.domain.common' xsi:nil='true' /><ModifiedBy xmlns='java:COM.soundbite.service.domain.common' xsi:nil='true' /><CreatedDate xmlns='java:COM.soundbite.service.domain.common' xsi:nil='true' /><UpdatedDate xmlns='java:COM.soundbite.service.domain.common' xsi:nil='true' /><InternalId xmlns='java:COM.soundbite.service.domain.common'>%@</InternalId><ExternalId xmlns='java:COM.soundbite.service.domain.organization' xsi:nil='true' /><Name xmlns='java:COM.soundbite.service.domain.organization' xsi:nil='true' /><Parent xmlns='java:COM.soundbite.service.domain.organization' xsi:nil='true' /><Type xmlns='java:COM.soundbite.service.domain.organization'>Account</Type></arg1><arg2 xmlns=''>2000-06-12T16:50:38.4952702-04:00</arg2><arg3 xmlns=''>2100-06-12T16:50:38.4952702-04:00</arg3></listCampaigns></soap:Body></soap:Envelope>"
#define	klistCampaignsUrlTemplate			@"https://%@.soundbite.com/SOAPAPI/CampaignManagementService"

#define klistSubCampaignsRequestTemplate    @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:wsa='http://schemas.xmlsoap.org/ws/2004/08/addressing' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:wsse='http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd' xmlns:wsu='http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/' xmlns:xsd='http://www.w3.org/2001/XMLSchema'><soap:Header><wsa:Action></wsa:Action><wsa:To>https://service3.soundbite.com/SOAPAPI/CampaignManagementService</wsa:To><wsse:Security><wsse:UsernameToken ><wsse:Username>%@</wsse:Username><wsse:Password>%@</wsse:Password></wsse:UsernameToken></wsse:Security></soap:Header><soap:Body><listSubCampaignStates xmlns='http://www.soundbite.com/SOAPAPI'><arg1><InternalId xmlns='java:COM.soundbite.service.domain.common'>%@</InternalId><Type xmlns='java:COM.soundbite.service.domain.organization'>Account</Type></arg1><arg2/><arg3>2010-10-01</arg3><arg4>2100-01-01</arg4></listSubCampaignStates></soap:Body></soap:Envelope>"
#define	klistSubCampaignsUrlTemplate			@"https://%@.soundbite.com/SOAPAPI/CampaignManagementService"

#define	klistListsRequestTemplate			@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:wsa='http://schemas.xmlsoap.org/ws/2004/08/addressing' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:wsse='http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd' xmlns:wsu='http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/' xmlns:xsd='http://www.w3.org/2001/XMLSchema'><soap:Header><wsa:Action></wsa:Action><wsa:ReplyTo><wsa:Address>http://schemas.xmlsoap.org/ws/2004/08/addressing/role/anonymous</wsa:Address></wsa:ReplyTo><wsa:To>https://service4.soundbite.com/SOAPAPI/ContactManagementService</wsa:To><wsse:Security soap:mustUnderstand='1'><wsse:UsernameToken xmlns:wsu='http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd'><wsse:Username>%@</wsse:Username><wsse:Password Type='http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText'>%@</wsse:Password></wsse:UsernameToken></wsse:Security></soap:Header><soap:Body><listLists xmlns='http://www.soundbite.com/SOAPAPI'><arg1 xmlns='' xmlns:q1='java:COM.soundbite.service.domain.organization' xsi:type='q1:Org'><CreatedBy xmlns='java:COM.soundbite.service.domain.common' xsi:nil='true' /><ModifiedBy xmlns='java:COM.soundbite.service.domain.common' xsi:nil='true' /><CreatedDate xmlns='java:COM.soundbite.service.domain.common' xsi:nil='true' /><UpdatedDate xmlns='java:COM.soundbite.service.domain.common' xsi:nil='true' /><InternalId xmlns='java:COM.soundbite.service.domain.common'>%@</InternalId><q1:ExternalId xsi:nil='true' /><q1:Name xsi:nil='true' /><q1:Parent xsi:nil='true' /><q1:Type>Account</q1:Type></arg1><arg2 xmlns=''></arg2></listLists></soap:Body></soap:Envelope>"
#define	klistListsUrlTemplate				@"https://%@.soundbite.com/SOAPAPI/ContactManagementService"

#define	kshowListRequestTemplate			@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:wsa='http://schemas.xmlsoap.org/ws/2004/08/addressing' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance'xmlns:wsse='http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd'xmlns:wsu='http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd'xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:java='java:COM.soundbite.service.domain.common'><soap:Header><wsa:Action></wsa:Action><wsa:ReplyTo><wsa:Address>http://schemas.xmlsoap.org/ws/2004/08/addressing/role/anonymous</wsa:Address></wsa:ReplyTo><wsa:To></wsa:To><wsse:Security soap:mustUnderstand='1'><wsse:UsernameToken xmlns:wsu='http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd'><wsse:Username>%@</wsse:Username><wsse:Password Type='http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText'>%@</wsse:Password></wsse:UsernameToken></wsse:Security></soap:Header><soap:Body><showList xmlns='http://www.soundbite.com/SOAPAPI'><arg1><java:InternalId >%@</java:InternalId><java:Type>Standard</java:Type><java:IsDeleted>false</java:IsDeleted></arg1></showList></soap:Body></soap:Envelope>"
#define	kshowListUrlTemplate				@"https://%@.soundbite.com/SOAPAPI/ContactManagementService"

#define	klistScriptsRequestTemplate			@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:wsa='http://schemas.xmlsoap.org/ws/2004/08/addressing' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:wsse='http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd' xmlns:wsu='http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/' xmlns:xsd='http://www.w3.org/2001/XMLSchema'><soap:Header><wsa:Action></wsa:Action><wsa:ReplyTo><wsa:Address>http://schemas.xmlsoap.org/ws/2004/08/addressing/role/anonymous</wsa:Address></wsa:ReplyTo><wsa:To>https://service4.soundbite.com/SOAPAPI/CampaignManagementService</wsa:To><wsse:Security soap:mustUnderstand='1'><wsse:UsernameToken xmlns:wsu='http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd'><wsse:Username>%@</wsse:Username><wsse:Password Type='http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText'>%@</wsse:Password></wsse:UsernameToken></wsse:Security></soap:Header><soap:Body><listScripts xmlns='http://www.soundbite.com/SOAPAPI'><arg1 xmlns=''><CreatedBy xmlns='java:COM.soundbite.service.domain.common' xsi:nil='true' /><ModifiedBy xmlns='java:COM.soundbite.service.domain.common' xsi:nil='true' /><CreatedDate xmlns='java:COM.soundbite.service.domain.common' xsi:nil='true' /><UpdatedDate xmlns='java:COM.soundbite.service.domain.common' xsi:nil='true' /><InternalId xmlns='java:COM.soundbite.service.domain.common'>%@</InternalId><ExternalId xmlns='java:COM.soundbite.service.domain.organization' xsi:nil='true' /><Name xmlns='java:COM.soundbite.service.domain.organization' xsi:nil='true' /><Parent xmlns='java:COM.soundbite.service.domain.organization' xsi:nil='true' /><Type xmlns='java:COM.soundbite.service.domain.organization'>Account</Type></arg1></listScripts></soap:Body></soap:Envelope>"
#define	klistScriptsUrlTemplate				@"https://%@.soundbite.com/SOAPAPI/CampaignManagementService"

#define	kshowSystemInfoRequestTemplate		@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:wsa=\"http://schemas.xmlsoap.org/ws/2004/08/addressing\" xmlns:wsse=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd\" xmlns:wsu=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd\"><soap:Header><wsa:Action></wsa:Action><wsa:To>https://service4.soundbite.com/SOAPAPI/PlatformManagementService</wsa:To><wsse:Security><wsse:UsernameToken><wsse:Username>%@</wsse:Username><wsse:Password>%@</wsse:Password></wsse:UsernameToken></wsse:Security></soap:Header><soap:Body><showSystemInfo xmlns=\"http://www.soundbite.com/SOAPAPI\" /></soap:Body></soap:Envelope>"
#define	kshowSystemInfoUrlTemplate			@"https://%@.soundbite.com/SOAPAPI/PlatformManagementService"


@interface SBSoap2 : NSObject {
	//@private id m_Delegate;
	//@private NSURLConnection *theConnection;
	id m_Delegate;
	NSURLConnection *theConnection;
	NSMutableData *webData;
}

@property (nonatomic, strong) User *currentUser;
@property BOOL error;
@property BOOL workInProgress;
@property (nonatomic, strong) GDataXMLDocument *doc;

- (void)setDelegate:(id)new_delegate;
- (void)request:(User *)user requestTemplate:(NSString *)requestTemplate urlTemplate:(NSString *)urlTemplate delegate:(id)delegate;
- (void)request:(User *)user message:(NSString *)soapMessage urlTemplate:(NSString *)urlTemplate delegate:(id)delegate;
//- (void)request:(User *)user requestTemplate:(NSString *)requestTemplate urlTemplate:(NSString *)urlTemplate filter:(NSString *)filter delegate:(id)delegate;
- (void)abortDownload;
- (NSString *)removeXMLNamespaces:(NSString *)xmlWithNS;

@end

@interface NSObject (SBSoapDelegate)
- (void)dataIsReady:(SBSoap2 *)sbSoap;
@end
