//
//  AvaTransactionInteractorOutput.h
//  MyEtherWallet-iOS
//
//  Created by Collin Montag on 12/6/19.
//  Copyright © 2019 MyEtherWallet, Inc. All rights reserved.
//

@import Foundation;

@protocol AvaTransactionInteractorOutput <NSObject>
- (void) didCompleteTransaction;
@end
