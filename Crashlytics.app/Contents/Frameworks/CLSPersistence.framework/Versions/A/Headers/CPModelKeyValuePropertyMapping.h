//
//  CPModelKeyValuePropertyMapping.h
//  CLSPersistence
//
//  Created by Matt Massicotte on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CPPropertyMapping.h"

@interface CPModelKeyValuePropertyMapping : CPPropertyMapping {
    NSString* _modelKey;
}

@property (nonatomic, copy) NSString* modelKey;

@end
