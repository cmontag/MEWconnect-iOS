//
//  AvaTransactionViewOutput.h
//  MyEtherWallet-iOS
//
//  Created by Collin Montag on 12/6/19.
//  Copyright © 2019 MyEtherWallet, Inc. All rights reserved.
//

@import Foundation;

@protocol AvaTransactionViewOutput <NSObject>
- (void) didTriggerViewReadyEvent;
- (void) makeTransactionActionToAddress:(NSString *)toAddress ofAsset:(NSString *)assetId ofAmount:(NSNumber *)amount;
- (void) closeAction;
@end
