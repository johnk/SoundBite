//
//  CLSWebRequest.h
//  CLSWebClient
//
//  Created by Matt Massicotte on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL (^CLSWebClientCanAuthenticateAgainstProtectionSpaceHandler)(NSURLProtectionSpace* protectionSpace);

@interface CLSWebRequest : NSObject {
    NSString*                                                _method;
    NSString*                                                _path;
    NSURL*                                                   _URL;
    NSDictionary*                                            _parameters;
    NSMutableDictionary*                                     _customHeaders;
    NSMutableArray*                                          _formFields;
    CLSWebClientCanAuthenticateAgainstProtectionSpaceHandler _protectionSpaceHandler;
}

+ (id)requestWithMethod:(NSString*)method path:(NSString*)path;

- (id)initWithMethod:(NSString*)method;

@property (nonatomic, copy)             NSString*     path;
@property (nonatomic, retain)           NSDictionary* parameters;
@property (nonatomic, retain)           NSURL*        URL;
@property (nonatomic, retain, readonly) NSURL*        fullURL;
@property (nonatomic, retain, readonly) NSURLRequest* URLRequest;
@property (nonatomic, copy)             NSString*     method;
@property (nonatomic, copy)             CLSWebClientCanAuthenticateAgainstProtectionSpaceHandler protectionSpaceHandler;

- (void)addValue:(NSString*)value forHTTPHeaderField:(NSString*)field;
- (void)addHeaders:(NSDictionary*)headers;

- (void)addValue:(id)value forFormField:(NSString*)name;
- (void)addData:(NSData*)data MIMEType:(NSString*)type fileName:(NSString*)filename forFormField:(NSString*)name;

- (void)setFormData:(NSDictionary*)dictionary;

@end
