//
//  CPPersistentObjectErrors.h
//  CLSPersistence
//
//  Created by Matt Massicotte on 6/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

extern NSString* const CPPersistentObjectErrorDomain;

typedef enum {
    CPPersistentObjectResponseCodeDidNotMatch = -1,
    CPPersistentObjectCacheLookupFailure      = -2,
    CPPersistentObjectWebWriteFailure         = -3,
    CPPersistentObjectReloadFailure           = -4
} CPPersistentObjectError;
