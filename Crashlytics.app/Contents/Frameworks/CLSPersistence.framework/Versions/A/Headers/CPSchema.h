//
//  CPSchema.h
//  CLSPersistence
//
//  Created by Matt Massicotte on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPCache.h"
#import "CPPolicy.h"
#import "CPRelationship.h"
#import "CPRequest.h"

@class CPPersistentObject;
@class CPPropertyMapping;

@interface CPSchema : NSObject {
    NSString*     _resourceSingularName;
    NSString*     _resourceSingularPath;
    NSString*     _resourcePluralName;
    NSString*     _resourcePluralPath;
    CPReadPolicy  _defaultReadPolicy;
    CPWritePolicy _defaultWritePolicy;
    NSString*     _modelPrimaryKey;
    NSString*     _resourcePrimaryKey;
    Class         _modelClass;
    
    CPPathConstructionBlock _singularResourcePath;
    CPPathConstructionBlock _collectionResourcePath;
    NSString*               _singularPath;
    NSString*               _collectionPath;
    
    NSMutableDictionary* _resourceKeyMappings;
    NSMutableDictionary* _relationships;
}

- (id)initWithClass:(Class)aClass;

@property (nonatomic, copy)   NSString*               resourceSingularName;
@property (nonatomic, copy)   NSString*               resourceSingularPath;
@property (nonatomic, copy)   NSString*               resourcePluralName;
@property (nonatomic, copy)   NSString*               resourcePluralPath;
@property (nonatomic, assign) CPReadPolicy            defaultReadPolicy;
@property (nonatomic, assign) CPWritePolicy           defaultWritePolicy;
@property (nonatomic, copy)   NSString*               modelPrimaryKey;
@property (nonatomic, assign) Class                   modelClass;
@property (nonatomic, copy)   NSString*               resourcePrimaryKey;

- (void)setSingularResourceName:(NSString*)name path:(NSString*)path;
- (void)setPluralResourceName:(NSString*)name path:(NSString*)path;

- (CPRequest*)newRequestForRelationship:(NSString*)name toModel:(CPPersistentObject*)modelObject;

// old-style

@property (nonatomic, copy)   CPPathConstructionBlock singularResourcePath;
@property (nonatomic, copy)   CPPathConstructionBlock collectionResourcePath;
@property (nonatomic, copy)   NSString*               singularPath;
@property (nonatomic, copy)   NSString*               collectionPath;

- (CPPropertyMapping*)mappingForResourceKey:(NSString*)key;
- (CPRelationship*)relationshipForResourceKey:(NSString*)key;

- (void)mapResourceKey:(NSString*)resourceKey toKey:(NSString*)key mappingPolicy:(CPMappingPolicy)policy optional:(BOOL)optional;
- (void)mapResourceKey:(NSString*)resourceKey toPrimaryKey:(NSString*)key;
- (void)mapResourceKey:(NSString*)resourceKey toKey:(NSString*)key mappingPolicy:(CPMappingPolicy)policy;
- (void)mapResourceKey:(NSString*)resourceKey toKey:(NSString*)key optional:(BOOL)optional;
- (void)mapResourceKey:(NSString*)resourceKey toKey:(NSString*)key;
- (void)mapResourceKey:(NSString*)resourceKey mappingPolicy:(CPMappingPolicy)policy usingGetBlock:(id (^)(id obj))block;
- (void)mapResourceKey:(NSString*)resourceKey usingGetBlock:(id (^)(id obj))block;
- (void)mapResourceKey:(NSString*)resourceKey mappingPolicy:(CPMappingPolicy)policy usingSetBlock:(BOOL (^)(id obj, id value))block;
- (void)mapResourceKey:(NSString*)resourceKey usingSetBlock:(BOOL (^)(id obj, id value))block;

- (void)defineRelationship:(NSString *)relationshipName toClass:(Class)childClass cardinality:(CPCardinality)cardinality path:(NSString*)path;

- (void)hasMany:(NSString*)relationshipName   ofKind:(Class)aClass path:(NSString*)path;
- (void)hasOne:(NSString*)relationshipName    ofKind:(Class)aClass path:(NSString*)path;
- (void)belongsTo:(NSString*)relationshipName ofKind:(Class)aClass path:(NSString*)path;

// Mapping

// These methods require special care for thread-safety because they access both self and a model object
- (BOOL)mapDictionary:(NSDictionary*)dictionary toModel:(CPPersistentObject*)object forWeb:(BOOL)forWeb error:(NSError**)error;
- (NSDictionary*)buildDictionaryFromModel:(CPPersistentObject*)object forWeb:(BOOL)forWeb error:(NSError**)error;

@end
