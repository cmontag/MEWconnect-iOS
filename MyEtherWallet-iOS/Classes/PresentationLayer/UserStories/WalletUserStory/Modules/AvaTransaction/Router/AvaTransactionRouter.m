//
//  AvaTransactionRouter.m
//  MyEtherWallet-iOS
//
//  Created by Collin Montag on 12/11/19.
//  Copyright © 2019 MyEtherWallet, Inc. All rights reserved.
//

@import ViperMcFlurryX;

#import "AvaTransactionRouter.h"

@implementation AvaTransactionRouter

#pragma mark - ShareRouterInput

- (void) close {
  [self.transitionHandler closeCurrentModule:YES];
}

@end
