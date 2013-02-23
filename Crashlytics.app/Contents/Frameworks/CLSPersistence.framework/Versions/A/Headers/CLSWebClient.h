//
//  CLSWebClient.h
//  CLSWebClient
//
//  Created by Matt Massicotte on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CLSWebRequest.h"
#import "CLSWebResponse.h"

#import <Foundation/Foundation.h>

@protocol CLSPersistenceCacheDelegate;

typedef void (^CLSWebClientCompletionHandler)(CLSWebResponse* response);

@interface CLSWebClient : NSObject {
    NSURL*               _url;
    NSMutableSet*        _connections;
    dispatch_queue_t     _queue;
    NSMutableDictionary* _customHeaders;
    
    id <CLSPersistenceCacheDelegate> _cacheDelegate;
}

+ (NSString*)escapeURLString:(NSString*)string;
+ (id)decodeJSON:(NSData*)data;
+ (NSData*)encodeJSON:(id)object;

- (id)initWithURL:(NSURL *)url;

@property (nonatomic, retain, readonly) NSURL* URL;
@property (nonatomic, assign)           id <CLSPersistenceCacheDelegate> cacheDelegate;

- (void)addValue:(NSString*)value forHeader:(NSString*)header;

- (void)startRequest:(CLSWebRequest*)request completion:(CLSWebClientCompletionHandler)block;
- (void)startRequest:(CLSWebRequest *)request expectingResponse:(NSUInteger)code completion:(void (^)(CLSWebResponse* response))block;
#if !SDK
- (void)syncStartRequest:(CLSWebRequest*)request completion:(CLSWebClientCompletionHandler)block;
- (void)syncStartRequest:(CLSWebRequest *)request expectingResponse:(NSUInteger)code completion:(void (^)(CLSWebResponse* response))block;
#endif
- (void)getPath:(NSString*)path completion:(CLSWebClientCompletionHandler)block;
- (void)getURL:(NSURL*)url completion:(CLSWebClientCompletionHandler)block;

// note that the formContents dictionary uses types to encode values.  NSStrings => strings, NSURLs (for which isFileURL returns true)
// map to binary-encoded files.
- (void)postFormData:(NSDictionary*)formContents toPath:(NSString*)path completion:(CLSWebClientCompletionHandler)block;

@end
