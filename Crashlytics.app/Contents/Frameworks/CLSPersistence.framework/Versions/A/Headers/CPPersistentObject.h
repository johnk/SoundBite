//
//  CPPersistentObject.h
//  CLSPersistence
//
//  Created by Matt Massicotte on 6/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPPolicy.h"
#import "CPRelationship.h"
#import "CPPersistentObjectErrors.h"

@class CLSWebClient;
@class CPSchema;
@class CPContext;
@class CPRequest;
@class CPPersistentObject;

@interface CPPersistentObject : NSObject {
    BOOL _isNewRecord;
}

// interacting with the context
+ (void)getGlobalDefaultContext:(void (^)(CPContext* context))block;
+ (void)setGlobalDefaultContext:(CPContext*)context;

// defining the model
+ (void)getModelSchema:(void (^)(CPSchema* schema))block;

// Object Finders
+ (void)find:(id <NSObject>)identifier inContext:(CPContext*)context withReadPolicy:(CPReadPolicy)policy completion:(void (^)(id obj))block;
+ (void)find:(id <NSObject>)identifier withReadPolicy:(CPReadPolicy)policy completion:(void (^)(id obj))block;

+ (void)findAllWithCachePolicy:(CPReadPolicy)policy completion:(void (^)(NSArray* array))block;

// Relationship Finders
- (void)findToManyRelationship:(NSString*)name withReadPolicy:(CPReadPolicy)policy completion:(void (^)(NSArray* array))block;
- (void)findToManyRelationship:(NSString*)name completion:(void (^)(NSArray* array))block;
- (void)findToOneRelationship:(NSString*)name withReadPolicy:(CPReadPolicy)policy completion:(void (^)(id owner))block;
- (void)findToOneRelationship:(NSString*)name completion:(void (^)(id owner))block;
- (void)findOwnerRelationship:(NSString*)name withReadPolicy:(CPReadPolicy)policy completion:(void (^)(id owner))block;
- (void)findOwnerRelationship:(NSString*)name completion:(void (^)(id owner))block;

// Relationship Enumerators
- (void)enumerateToManyRelationship:(NSString*)name withReadPolicy:(CPReadPolicy)policy usingBlock:(void (^)(id obj, BOOL last, BOOL* stop))block;
- (void)enumerateToManyRelationship:(NSString*)name usingBlock:(void (^)(id obj, BOOL last, BOOL* stop))block;

// Saving
- (void)saveWithWritePolicy:(CPWritePolicy)policy completion:(void (^)(NSError* error))block;
- (void)save:(void (^)(NSError* error))block;

// Reloading
- (void)reloadWithReadPolicy:(CPReadPolicy)policy completion:(void (^)(NSError* error))block;
- (void)reload:(void (^)(NSError* error))block;

// Instance life-cycle Hooks
- (void)afterSave;
- (void)afterUpdate;
- (void)afterCreate;
- (void)afterDestroy;

- (void)afterLoad;
- (void)afterCache;

@property (nonatomic, assign, readonly) BOOL isNewRecord;

@end
