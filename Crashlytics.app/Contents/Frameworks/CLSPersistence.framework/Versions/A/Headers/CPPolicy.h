//
//  CPPolicy.h
//  CLSPersistence
//
//  Created by Matt Massicotte on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#pragma once

typedef enum {
    CPReadPolicyDefault         = 0, // use model's default read policy
    CPReadPolicyWebOnFailure    = 1, // cache first, remote on failure
    CPReadPolicyWebOnly         = 2, // never touch cache
    CPReadPolicyCacheOnly       = 3, // never touch the remote
    CPReadPolicyCacheWithReload = 4, // cache first, web second
    CPReadPolicyCacheOnFailure  = 5  // web first, cache on failure
} CPReadPolicy;

typedef enum {
    CPWritePolicyDefault = 0, // model's default write policy
    CPWriteWebAfterCache = 1, // write to cache, then write to web
    CPWriteCacheAfterWeb = 2, // write to web, then cache
    CPWriteCacheAndWeb   = 3, // write to both cache and web concurrently
    CPWriteCacheOnly     = 4, // write to cache, do not touch web
    CPWriteWebOnly       = 5, // write to web, do not touch cache
    CPWriteNoAutoSave    = 6  // don't write to the cache automatically.
} CPWritePolicy;

typedef enum {
    CPMappingWebAndCache  = 0,
    CPMappingWebOnly      = 1,
    CPMappingCacheOnly    = 2,
    CPMappingInMemoryOnly = 3
} CPMappingPolicy;

#define CPMappingDefault CPMappingWebAndCache
