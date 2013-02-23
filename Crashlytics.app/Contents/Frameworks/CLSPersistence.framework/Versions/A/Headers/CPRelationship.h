//
//  CPRelationship.h
//  CLSPersistence
//
//  Created by Matt Massicotte on 6/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CPCardinalityToMany,
    CPCardinalityToOne,
    CPCardinalityManyToMany,
    CPCardinalityFromOne,
    CPCardinalityIdentity
} CPCardinality;

typedef NSString* (^CPPathConstructionBlock)(id obj);

@interface CPRelationship : NSObject {
    CPCardinality   _cardinality;
    NSString*       _name;
    NSString*       _modelKeyPath;
    NSString*       _resourceKeyPath;
    Class           _ownerClass;
    Class           _relatedClass;
    NSString*       _path;
    CPRelationship* _inverseRelationship;
    CPPathConstructionBlock _pathBlock;
}

@property (nonatomic, assign) CPCardinality   cardinality;
@property (nonatomic, copy)   NSString*       name;
@property (nonatomic, copy)   NSString*       modelKeyPath;
@property (nonatomic, copy)   NSString*       resourceKeyPath;
@property (nonatomic, assign) Class           ownerClass;
@property (nonatomic, assign) Class           relatedClass;
@property (nonatomic, copy)   NSString*       path;
@property (nonatomic, assign) CPRelationship* inverseRelationship;

@property (nonatomic, copy)   CPPathConstructionBlock pathBlock;

@end
