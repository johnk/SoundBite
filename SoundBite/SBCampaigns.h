//
//  SBCampaigns.h
//  SoundBite
//
//  Created by John Keyes on 2/26/11.
//  Copyright 2011 johnkeyes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CWLSynthesizeSingleton.h"
#import "User.h"
#import "SBSoap2.h"


@interface SBCampaigns : NSObject

@property (nonatomic, strong) SBSoap2 *sbSoap;
@property (nonatomic, unsafe_unretained) User *currentUser;

CWL_DECLARE_SINGLETON_FOR_CLASS(SBCampaigns)
//+ (SBCampaigns *)sharedSBCampaigns;

- (void)loadForUser:(User *)sbUser withDelegate:(id)delegate;
@property (NS_NONATOMIC_IOSONLY, readonly) NSInteger count;
- (NSString *)nameForRow:(NSInteger)row;
- (NSString *)startDateForRow:(NSInteger)row;
- (NSString *)endDateForRow:(NSInteger)row;

@end
