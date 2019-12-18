//
//  AvaTransactionModuleInput.h
//  MyEtherWallet-iOS
//
//  Created by Collin Montag on 12/6/19.
//  Copyright © 2019 MyEtherWallet, Inc. All rights reserved.
//

@import Foundation;
@import ViperMcFlurryX;

#import "MasterTokenPlainObject.h"

@protocol AvaTransactionModuleInput <RamblerViperModuleInput>

- (void) configureModuleWithMasterToken:(MasterTokenPlainObject *)masterToken;

@end
