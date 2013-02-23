//
//  CPCoreDataCache.h
//  CLSPersistence
//
//  Created by Matt Massicotte on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CPCache.h"

@interface CPCoreDataCache : NSObject <CPCaching> {
    dispatch_queue_t _queue;
    NSURL*           _cacheURL;
    
    NSArray*                      _modelBundles;
    NSManagedObjectModel*         _managedObjectModel;
    NSManagedObjectContext*       _managedObjectContext;
    NSPersistentStoreCoordinator* _storeCoordinator;
    
    BOOL _debugLogging;
}

- (id)initWithURL:(NSURL*)cacheURL;

@property (nonatomic, retain) NSArray* modelBundles;

@end
