//
//  AvaTransactionPresenter.m
//  MyEtherWallet-iOS
//
//  Created by Collin Montag on 12/6/19.
//  Copyright © 2019 MyEtherWallet, Inc. All rights reserved.
//

@import MagicalRecord;

#import "AvaTransactionPresenter.h"

#import "AvaTransactionViewInput.h"
#import "AvaTransactionInteractorInput.h"
#import "AvaTransactionRouterInput.h"

#import "AccountPlainObject.h"
#import "AccountModelObject.h"
#import "NetworkModelObject.h"

@implementation AvaTransactionPresenter

#pragma mark - SettingsModuleInput

- (void) configureModuleWithMasterToken:(MasterTokenPlainObject *)masterToken {
  [self.interactor configureWithMasterToken:masterToken];
}

#pragma mark - SettingsViewOutput

- (void) didTriggerViewReadyEvent {
  MasterTokenPlainObject *masterToken = [self.interactor obtainMasterToken];
  [self.view setupInitialStateWithMasterToken:masterToken];
}

- (void) closeAction {
  [self.router close];
}

- (void) didCompleteTransaction {
  [self.router close];
}

- (void) makeTransactionActionToAddress:(NSString *)toAddress ofAsset:(NSString *)assetId ofAmount:(NSNumber *)amount {
  [self.interactor sendRawTransactionToAddress:toAddress ofAsset:assetId ofAmount:amount];
}

#pragma mark - SettingsInteractorOutput

@end
