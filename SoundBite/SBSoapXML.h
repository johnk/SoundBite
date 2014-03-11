//
//  SBSoapXML.h
//  SoundBite
//
//  Created by John Keyes on 3/6/2014.
//  Copyright 2009 John Keyes. All rights reserved.
//


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
#define klistLists                          @"<ns2:listLists xmlns:ns2=\"http://www.soundbite.com/SOAPAPI2/110\"><arg1 xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:type=\"ns2:org\"><internalId>%@</internalId><type>Account</type></arg1><arg2><externalId></externalId><isDeleted>false</isDeleted></arg2></ns2:listLists>"

// listOrgs: enterprise number
#define klistOrgs                           @"<ns2:listOrgs><arg1><internalId>%@</internalId><type>Enterprise</type></arg1><arg2><attributes><name>enabled</name><value>true</value></attributes><type>Account</type></arg2>"

// listScripts: account number
#define klistScripts                        @"<ns:listScripts><arg1><internalId>%@</internalId><type>Account</type></arg1></ns:listScripts>"

// listSubCampaignStates:
#define klistSubCampaignStates              @"<ns:listSubCampaignStates><arg1><internalId>%@</internalId><type>Account</type></arg1><arg2><state></state></arg2><arg3>2000-06-12T16:50:38.4952702-04:00</arg3><arg4>2100-06-12T16:50:38.4952702-04:00</arg4></ns:listSubCampaignStates>"

// showCurrentSession:
#define kshowCurrentSession                 @"<ns:showCurrentSession/>"

// showList:
#define kshowList                           @"<ns2:showList xmlns:ns2=\"http://www.soundbite.com/SOAPAPI2/110\"><arg1 xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:type=\"ns2:org\"><internalId>%@</internalId><type>Standard</type><isDeleted>false</isDeleted></arg1></ns2:showList>"

// showSystemInfo: -
#define kshowSystemInfo                     @"<ns:showSystemInfo/>"

// showUser: user name
#define kshowUser                           @"<ns:showUser><arg1><externalId>%@</externalId></arg1></ns:showUser>"
