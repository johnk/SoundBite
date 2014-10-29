//
//  SBScripts.h
//  SoundBite
//
//  Created by John Keyes on 12/11/2012.
//  Copyright 2012 John Keyes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CWLSynthesizeSingleton.h"
#import "User.h"
#import "SBSoap2.h"


@interface SBScripts : NSObject

@property (nonatomic, strong) SBSoap2 *sbSoap;
@property (nonatomic, unsafe_unretained) User *currentUser;

CWL_DECLARE_SINGLETON_FOR_CLASS(SBScripts)
//+ (SBScripts *)sharedSBScripts;

- (void)loadForUser:(User *)user withDelegate:(id)delegate;
@property (NS_NONATOMIC_IOSONLY, readonly) NSInteger count;
- (NSString *)nameForRow:(NSInteger)row;
- (NSString *)versionForRow:(NSInteger)row;
- (NSString *)descriptionForRow:(NSInteger)row;

@end
