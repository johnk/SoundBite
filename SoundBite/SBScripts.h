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


@interface SBScripts : NSObject {
	SBSoap2 *sbSoap;
    User *__unsafe_unretained currentUser;
}

@property (nonatomic, strong) SBSoap2 *sbSoap;
@property (nonatomic, unsafe_unretained) User *currentUser;

CWL_DECLARE_SINGLETON_FOR_CLASS(SBScripts)
//+ (SBScripts *)sharedSBScripts;

- (void)loadForUser:(User *)user withDelegate:(id)delegate;
- (NSInteger)count;
- (NSString *)nameForRow:(NSInteger)row;
- (NSString *)versionForRow:(NSInteger)row;
- (NSString *)descriptionForRow:(NSInteger)row;

@end
