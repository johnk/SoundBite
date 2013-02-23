//
//  CPFindDescriptor.h
//  CLSPersistence
//
//  Created by Matt Massicotte on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPSchema.h"

@class CPContext;

@interface CPRequest : NSObject {
    NSString*     _resourceName;
    NSString*     _resourcePrimaryKey;
    Class         _resourceClass;
    NSString*     _path;
    NSString*     _HTTPMethod;
    NSDictionary* _matchingDictionary;
}

@property (nonatomic, copy)   NSString*     resourceName;
@property (nonatomic, copy)   NSString*     resourcePrimaryKey;
@property (nonatomic, assign) Class         resourceClass;
@property (nonatomic, copy)   NSString*     path;
@property (nonatomic, copy)   NSString*     HTTPMethod;
@property (nonatomic, retain) NSDictionary* matchingDictionary;

@end
