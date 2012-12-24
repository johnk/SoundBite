//
//  SBList.h
//  SoundBite
//
//  Created by John Keyes on 12/11/2012.
//  Copyright 2012 John Keyes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CWLSynthesizeSingleton.h"
#import "User.h"
#import "SBSoap2.h"


@interface SBList : NSObject

@property (nonatomic, strong) SBSoap2 *sbSoap;
@property (nonatomic, unsafe_unretained) NSString *currentListInternalId;

CWL_DECLARE_SINGLETON_FOR_CLASS(SBList)
//+ (SBList *)sharedSBList;

- (void)loadForUser:(User *)user list:(NSString *)listInternalId withDelegate:(id)delegate;
- (NSInteger)count;
- (NSString *)name;
- (NSString *)size;
- (NSString *)useCount;


@end
