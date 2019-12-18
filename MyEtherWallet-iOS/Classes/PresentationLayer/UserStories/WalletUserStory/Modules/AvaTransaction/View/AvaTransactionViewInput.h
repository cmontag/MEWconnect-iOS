//
//  AvaTransactionViewInput.h
//  MyEtherWallet-iOS
//
//  Created by Collin Montag on 12/6/19.
//  Copyright © 2019 MyEtherWallet, Inc. All rights reserved.
//

@import Foundation;

#import "MasterTokenPlainObject.h"

@protocol AvaTransactionViewInput <NSObject>

- (void) setupInitialStateWithMasterToken:(MasterTokenPlainObject *) masterToken;

@end
