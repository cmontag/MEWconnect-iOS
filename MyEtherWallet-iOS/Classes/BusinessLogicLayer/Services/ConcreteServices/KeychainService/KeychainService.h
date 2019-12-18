//
//  KeychainService.h
//  MyEtherWallet-iOS
//
//  Created by Mikhail Nikanorov on 29/06/2018.
//  Copyright © 2018 MyEtherWallet, Inc. All rights reserved.
//

@import Foundation;

#import "BlockchainNetworkTypes.h"

@class KeychainAccountModel;
@class KeychainHistoryItemModel;

@class AccountPlainObject;
@class MasterTokenPlainObject;

NS_ASSUME_NONNULL_BEGIN

@protocol KeychainService <NSObject>
/**
 Obtaining all public addresses of stored private addresses
 
 @returns Array of @b KeychainItemModel
 */
- (NSArray <KeychainAccountModel *> * _Nullable) obtainStoredItems;
//Save
- (void) saveKeydata:(NSData *)keydata forAddress:(NSString *)address ofAccount:(AccountPlainObject *)account inChainID:(NSString *)chainID;
- (void) saveEntropy:(NSData *)entropyData ofAccount:(AccountPlainObject *)account;
- (void) saveBackupStatus:(BOOL)backup forAccount:(AccountPlainObject *)account;
- (void) savePurchaseUserId:(NSString *)userId forMasterToken:(MasterTokenPlainObject *)token;
//Obtain
- (NSData * _Nullable) obtainKeydataOfMasterToken:(MasterTokenPlainObject *)token ofAccount:(AccountPlainObject *)account inChainID:(NSString *)chainID;
- (NSData * _Nullable) obtainEntropyOfAccount:(AccountPlainObject *)account;
- (NSArray <KeychainHistoryItemModel *> * _Nullable) obtainPurchaseHistoryOfMasterToken:(MasterTokenPlainObject *)token;
- (BOOL) obtainBackupStatusForAccount:(AccountPlainObject *)account;
//Delete
- (void) removeDataOfAccount:(AccountPlainObject *)account;
- (void) resetKeychain;
/**
 Saving first launch date, if needed
 */
- (void) saveFirstLaunchDate;
/**
 Obtaining first launch date
 */
- (NSString * _Nullable) obtainFirstLaunchDateString;
- (NSDate * _Nullable) obtainFirstLaunchDate;
/**
 Obtaining number of password attempts
 */
- (NSInteger) obtainNumberOfPasswordAttempts;
/**
 Reset number of password attempts
 */
- (void) savePasswordAttempts:(NSInteger)attempts;
/**
 Obtain unlock date
 */
- (NSDate *) obtainPasswordUnlockDate;
/**
 Save password unlock date
 */
- (void) savePasswordUnlockDate:(NSDate *)date;
/**
 Obtain What's new version
 */
- (NSString *) obtainWhatsNewViewedVersion;
/**
 Store What's new version
 */
- (void) saveWhatsNewViewedVersion:(NSString *)version;
@end

NS_ASSUME_NONNULL_END
