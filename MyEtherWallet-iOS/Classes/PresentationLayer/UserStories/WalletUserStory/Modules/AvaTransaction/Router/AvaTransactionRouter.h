//
//  AvaTransactionRouter.h
//  MyEtherWallet-iOS
//
//  Created by Collin Montag on 12/6/19.
//  Copyright © 2019 MyEtherWallet, Inc. All rights reserved.
//

#import "AvaTransactionRouterInput.h"

@protocol RamblerViperModuleTransitionHandlerProtocol;

@interface AvaTransactionRouter : NSObject <AvaTransactionRouterInput>

@property (nonatomic, weak) id<RamblerViperModuleTransitionHandlerProtocol> transitionHandler;

@end
