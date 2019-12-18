//
//  AvaTransactionInteractorInput.h
//  MyEtherWallet-iOS
//
//  Created by Collin Montag on 12/6/19.
//  Copyright © 2019 MyEtherWallet, Inc. All rights reserved.
//

@import Foundation;

@class MasterTokenPlainObject;

@protocol AvaTransactionInteractorInput <NSObject>
- (void) configureWithMasterToken:(MasterTokenPlainObject *)masterToken;
- (MasterTokenPlainObject *) obtainMasterToken;
- (void) sendRawTransactionToAddress:(NSString *)toAddress ofAsset:(NSString *)assetId ofAmount:(NSNumber *)amount;
@end
