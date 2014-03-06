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
