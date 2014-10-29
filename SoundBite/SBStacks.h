//
//  SBStacks.h
//  SoundBite
//
//  Created by John Keyes on 3/29/14.
//  Copyright (c) 2014 John Keyes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CWLSynthesizeSingleton.h"

@interface SBStacks : NSObject

@property (nonatomic, strong) NSString *sbStackURL;
@property (nonatomic, strong) NSArray *sbStacks;

CWL_DECLARE_SINGLETON_FOR_CLASS(SBStacks)

@property (NS_NONATOMIC_IOSONLY, readonly) NSInteger count;

@end
