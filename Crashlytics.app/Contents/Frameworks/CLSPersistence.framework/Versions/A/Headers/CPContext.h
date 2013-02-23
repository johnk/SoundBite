//
//  CPContext.h
//  CLSPersistence
//
//  Created by Matt Massicotte on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPCache.h"

@class CLSWebClient;

@interface CPContext : NSObject {
    CLSWebClient*  _webClient;
    id <CPCaching> _cache;
    dispatch_queue_t _defaultQueue;
}

@property (nonatomic, retain) CLSWebClient*    webClient;
@property (nonatomic, retain) id <CPCaching>   cache;
@property (nonatomic, assign) dispatch_queue_t defaultQueue;

@end
