//
//  CPModelBlockMapping.h
//  CLSPersistence
//
//  Created by Matt Massicotte on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CPPropertyMapping.h"

@class CPPersistentObject;

typedef id (^CPModelBlockMappingGetBlock)(id obj);
typedef BOOL (^CPModelBlockMappingSetBlock)(id obj, id value);

@interface CPModelBlockMapping : CPPropertyMapping {
    CPModelBlockMappingGetBlock _getBlock;
    CPModelBlockMappingSetBlock _setBlock;
}

@property (nonatomic, copy) CPModelBlockMappingGetBlock getBlock;
@property (nonatomic, copy) CPModelBlockMappingSetBlock setBlock;

@end
