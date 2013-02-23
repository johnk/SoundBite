//
//  CPPropertyMapping.h
//  CLSPersistence
//
//  Created by Matt Massicotte on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPPolicy.h"

@class CPPersistentObject;

@interface CPPropertyMapping : NSObject {
    NSString*       _resourceKey;
    CPMappingPolicy _mappingPolicy;
    BOOL            _optional;
}

@property (nonatomic, copy)     NSString*       resourceKey;
@property (nonatomic, assign)   CPMappingPolicy mappingPolicy;
@property (nonatomic, readonly) BOOL            appliesForWebOnly;
@property (nonatomic, readonly) BOOL            isCacheOnly;
@property (nonatomic, assign)   BOOL            optional;

- (id)getValueFromModel:(CPPersistentObject*)object;
- (void)setValue:(id)value inModel:(CPPersistentObject*)object;

@end
