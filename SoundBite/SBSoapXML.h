//
//  SBSoapXML.h
//  SoundBite
//
//  Created by John Keyes on 3/6/2014.
//  Copyright 2009 John Keyes. All rights reserved.
//


// version 3 requests

#define kSBSoapURL                          @"https://%@.soundbite.com/SOAPAPI2/%@"

#define kUAT                                @"uat1"
#define kstack2                             @"service2"
#define kstack3                             @"service3"
#define kstack4                             @"service4"
#define kstack5                             @"service5"
#define kstack6                             @"service6"
#define kstack7                             @"service7"

#define kAuthenticationService              @"AuthenticationService110"
#define kCampaignManagementService          @"CampaignManagementService110"
#define kContactCenterManagementService     @"ContactCenterManagementService110"
#define kContactManagementService           @"ContactManagementService110"
#define kIdentityManagementService          @"IdentityManagementService110"
#define kOrganizationManagementService      @"OrganizationManagementService110"
#define kPlatformManagementService          @"PlatformManagementService110"
#define kReportManagementService            @"ReportManagementService110"

#define ksoapEnvelope                       @"<soapenv:Envelope xmlns:ns=\"http://www.soundbite.com/SOAPAPI2/110\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"><soapenv:Header>%@</soapenv:Header><soapenv:Body>%@</soapenv:Body></soapenv:Envelope>"

#define ksoapHeader                         @"<wsse:Security xmlns:wsse=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd\" xmlns:wsu=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd\"><wsse:UsernameToken wsu:Id=\"UsernameToken-34\"><wsse:Username>%@</wsse:Username><wsse:Password Type=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText\">%@</wsse:Password></wsse:UsernameToken></wsse:Security>"

// listCampaigns: account number
#define klistCampaigns                      @"<ns:listCampaigns><arg1><internalId>%@</internalId><type>Account</type></arg1></ns:listCampaigns>"

// listLists:
#define klistLists                          @""

// listOrgs: enterprise number
#define klistOrgs                           @"<ns2:listOrgs><arg1><internalId>%@</internalId><type>Enterprise</type></arg1><arg2><attributes><name>enabled</name><value>true</value></attributes><type>Account</type></arg2>"

// listScripts: account number
#define klistScripts                        @"<ns:listScripts><arg1><internalId>%@</internalId><type>Account</type></arg1></ns:listScripts>"

// listSubCampaignStates:
#define klistSubCampaignStates              @"<ns:listSubCampaignStates><arg1><internalId>%@</internalId><type>Account</type></arg1><arg2><state></state></arg2><arg3>2000-06-12T16:50:38.4952702-04:00</arg3><arg4>2100-06-12T16:50:38.4952702-04:00</arg4></ns:listSubCampaignStates>"

// showCurrentSession:
#define kshowCurrentSession                 @"<ns:showCurrentSession/>"

// showList:
#define kshowList                           @""

// showSystemInfo: -
#define kshowSystemInfo                     @"<ns:showSystemInfo/>"

// showUser: user name
#define kshowUser                           @"<ns:showUser><arg1><externalId>%@</externalId></arg1></ns:showUser>"


// version 1 requests

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

// version 2 requests

#define	kshowSystemInfoRequestTemplateV2		@"<soapenv:Envelope xmlns:ns=\"http://www.soundbite.com/SOAPAPI2/110\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"><soapenv:Header><wsse:Security xmlns:wsse=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd\" xmlns:wsu=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd\"><wsse:UsernameToken wsu:Id=\"UsernameToken-8\"><wsse:Username>%@</wsse:Username><wsse:Password Type=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText\">%@</wsse:Password><wsse:Nonce EncodingType=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-soap-message-security-1.0#Base64Binary\">TnWVSVXcu+SLtdXIQ3uMYA==</wsse:Nonce><wsu:Created>2014-03-02T15:42:19.508Z</wsu:Created></wsse:UsernameToken></wsse:Security></soapenv:Header><soapenv:Body><ns:showSystemInfo/></soapenv:Body></soapenv:Envelope>"
#define	kshowSystemInfoUrlTemplateV2			@"https://%@.soundbite.com/SOAPAPI2/PlatformManagementService110"
