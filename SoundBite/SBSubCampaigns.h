//
//  SBSubCampaigns.h
//  SoundBite
//
//  Created by John Keyes on 12/11/2012.
//  Copyright 2012 John Keyes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CWLSynthesizeSingleton.h"
#import "User.h"
#import "SBSoap2.h"


@interface SBSubCampaigns : NSObject {
	SBSoap2 *sbSoap;
    User *__unsafe_unretained currentUser;
    NSString *currentCampaign;
}

@property (nonatomic, strong) SBSoap2 *sbSoap;
@property (nonatomic, unsafe_unretained) User *currentUser;
@property (nonatomic, strong) NSString *currentCampaign;
@property (nonatomic) NSUInteger currentRow;

CWL_DECLARE_SINGLETON_FOR_CLASS(SBSubCampaigns)
//+ (SBSubCampaigns *)sharedSBSubCampaigns;

- (void)loadForUser:(User *)user withDelegate:(id)delegate;
- (NSInteger)count;
- (NSInteger)countPassesForSubCampaignInRow:(NSInteger)row;

- (NSString *)nameForRow:(NSInteger)row;
- (NSString *)statusForRow:(NSInteger)row;
- (NSString *)attemptedCountForRow:(NSInteger)row;
- (NSString *)notAttemptedCountForRow:(NSInteger)row;
- (NSString *)filteredCountForRow:(NSInteger)row;
- (NSString *)pendingCountForRow:(NSInteger)row;
- (NSString *)deliveredCountForRow:(NSInteger)row;
- (NSString *)failedCountForRow:(NSInteger)row;
//- (void)dataIsReady:(SBSoap2 *)sbSoapReady;

- (NSString *)description;

@end
