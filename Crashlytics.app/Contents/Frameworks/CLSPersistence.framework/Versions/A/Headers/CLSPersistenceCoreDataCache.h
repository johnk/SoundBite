//
//  CLSPersistenceCoreDataCache.h
//  CLSPersistence
//
//  Created by Matt Massicotte on 6/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPCache.h"
#import <CoreData/CoreData.h>

@interface CLSPersistenceCoreDataCache : NSObject <CLSPersistenceCacheDelegate> {
    NSString* _cacheDirectory;
    
    NSManagedObjectModel*         _managedObjectModel;
    NSManagedObjectContext*       _managedObjectContext;
    NSPersistentStoreCoordinator* _storeCoordinator;
    
    dispatch_queue_t _queue;
}

- (id)initWithCacheDirectory:(NSString*)directory;

@property (nonatomic, assign) dispatch_queue_t dispatchQueue;

// TODO: exposing this is horrendous
- (id)findEntities:(NSString*)entityName asDictionary:(BOOL)asDict withPredicate:(NSPredicate*)predicate error:(NSError**)error;

@end