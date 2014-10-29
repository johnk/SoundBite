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

@interface SBSubCampaigns : NSObject

@property (nonatomic, strong) SBSoap2 *sbSoap;
@property (nonatomic, unsafe_unretained) User *currentUser;
@property (nonatomic, strong) NSString *currentCampaign;
@property (nonatomic) NSUInteger currentRow;
@property (nonatomic, strong) NSString *currentInternalId;

CWL_DECLARE_SINGLETON_FOR_CLASS(SBSubCampaigns)
//+ (SBSubCampaigns *)sharedSBSubCampaigns;

- (void)loadForUser:(User *)user withDelegate:(id)delegate;

- (void)changeScStatus:(NSString *)newStatus;

// Methods for sub-campaign info

@property (NS_NONATOMIC_IOSONLY, readonly) NSInteger count;
- (NSString *)nameForRow:(NSInteger)row;
- (NSString *)internalIdForRow:(NSInteger)row;
- (NSString *)statusForRow:(NSInteger)row;
- (NSString *)attemptedCountForRow:(NSInteger)row;
//- (NSString *)notAttemptedCountForRow:(NSInteger)row;
//- (NSString *)filteredCountForRow:(NSInteger)row;
//- (NSString *)pendingCountForRow:(NSInteger)row;
- (NSString *)deliveredCountForRow:(NSInteger)row;
//- (NSString *)failedCountForRow:(NSInteger)row;
- (NSDictionary *)getAttributesForSub:(NSInteger)row;

// Methods for pass info

- (NSInteger)countPassesForSub:(NSInteger)row;
- (NSString *)passNameForSub:(NSInteger)row pass:(NSInteger)pass;
- (NSInteger)passChannelForSub:(NSInteger)row pass:(NSInteger)pass;
- (NSString *)passStatusForSub:(NSInteger)row pass:(NSInteger)pass;
- (NSDictionary *)getAttributesForSub:(NSInteger)row pass:(NSInteger)pass;

@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *description;

@end
