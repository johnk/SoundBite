//
//  CLSPersistentObject.h
//  CLSPersistence
//
//  Created by Matt Massicotte on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPPolicy.h"
#import "CPCache.h"
#import "CLSWebClient.h"

extern NSString* const CLSPersistentObjectErrorDomain;

typedef enum {
    CLSPersistentObjectResponseCodeDidNotMatch = -1,
    CLSPersistentObjectCacheLookupFailure      = -2
} CLSPersistentObjectError;

extern NSString* const CLSPersistentObjectDidChangeNotification;

@class CLSWebClient;
@class CLSWebRequest;

@interface CLSPersistentObject : NSObject {
    id _cachedRepresentation;
    
    CLSWebClient*   _RESTClient;
    dispatch_queue_t _queue;
}

+ (id)persistentObject;

// model description
+ (NSString*)modelSingularName;
+ (NSString*)modelPluralName;
+ (NSString*)modelPrimaryKey;

@property (nonatomic, assign, readonly) id <CLSPersistenceCacheDelegate> cacheDelegate;
@property (nonatomic, retain) CLSWebClient*                   RESTClient;
@property (nonatomic, assign) dispatch_queue_t                 dispatchQueue;

@property (nonatomic, copy,   readonly) NSString* resourcePath;
@property (nonatomic, copy,   readonly) NSString* createPath;
@property (nonatomic, copy,   readonly) NSString* updatePath;
@property (nonatomic, copy,   readonly) NSString* readPath;
@property (nonatomic, copy,   readonly) NSString* deletePath;
@property (nonatomic, assign, readonly) BOOL      isNewRecord; // this determines if we do a POST or a PUT
@property (nonatomic, retain)           id        cachedRepresentation; // for cache's use

// general query methods - these do not interface with the cache
- (void)startRequest:(CLSWebRequest *)request completion:(CLSWebClientCompletionHandler)handler;
- (void)startRequest:(CLSWebRequest *)request expectingResponse:(NSUInteger)code completion:(void (^)(CLSWebResponse* response))block;

// structured query methods - these are cachable
- (void)getArrayOfClass:(Class)objectClass atPath:(NSString*)path completion:(void (^)(NSArray* array, NSError* error))block;
- (void)getArrayOfClass:(Class)objectClass atPath:(NSString*)path withCachePolicy:(CPReadPolicy)policy completion:(void (^)(NSArray* array, NSError* error))block;
- (void)reload:(void (^)(NSError* error))block;
- (void)reloadWithCachePolicy:(CPReadPolicy)policy completion:(void (^)(NSError* error))block;

// subclass hooks
- (void)willIssueWebRequest:(CLSWebRequest*)request;
- (void)didChangeProperties;

// this is not a good API, but it is quick

- (void)takePropertiesFromDictionary:(NSDictionary*)dictionary;
- (NSDictionary*)propertiesAsDictionary;

- (Class)classForRelationship:(NSString*)relationName;
- (NSString*)resourcePathForRelationship:(NSString*)relationName;

- (void)fatalResponse:(CLSWebResponse*)response;

@end
