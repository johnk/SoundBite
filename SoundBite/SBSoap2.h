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
#import "SBSoapXML.h"


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

+ (NSURL *)sbSoapCreateURL:(NSString *)stack service:(NSString *)service;
+ (NSString *)sbSoapCreateRequest:(User *)user soapBody:(NSString *)soapBody;

- (void)sbSoapSendRequest:(NSURL *)url request:(NSString *)request delegate:(id)delegate;

- (void)setDelegate:(id)new_delegate;
- (void)abortDownload;
- (NSString *)removeXMLNamespaces:(NSString *)xmlWithNS;

@end

@interface NSObject (SBSoapDelegate)
- (void)dataIsReady:(SBSoap2 *)sbSoap;
@end
