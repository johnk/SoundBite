//
//  CPCache.h
//  CLSPersistence
//
//  Created by Matt Massicotte on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CLSPersistentCacheNoHits = -1,
    CLSPersistentCacheNoSuitableKeyForModel = -2,
    CLSPersistentCacheWriteFailure = -3
    
} CLSPersistentCacheError;

extern NSString* const CLSPersistentCacheErrorDomain;

@class CLSPersistentObject;

@protocol CLSPersistenceCacheDelegate <NSObject>
@required

// caching
- (BOOL)cacheObject:(CLSPersistentObject*)object completion:(void (^)(NSError* error))block;
- (BOOL)fetchObject:(CLSPersistentObject*)object completion:(void (^)(NSError* error))block;

- (BOOL)cacheArray:(NSArray*)array fetchedBy:(CLSPersistentObject*)object completion:(void (^)(NSError* error))block;
- (BOOL)fetchArrayOfClass:(Class)objectClass forObject:(CLSPersistentObject*)object completion:(void (^)(NSArray* array, NSError* error))block;

- (void)resetCache;

@end

@class CPPersistentObject;
@class CPSchema;
@class CPRequest;

@protocol CPCaching <NSObject>
@required

// meta operations
- (void)resetCache;

// caching operations
- (BOOL)loadObjectsFromRequest:(CPRequest*)request completion:(void (^)(NSArray* results))block;
- (BOOL)saveObjects:(NSArray*)objects fromRequest:(CPRequest*)request completion:(void (^)(BOOL success))block;

@end