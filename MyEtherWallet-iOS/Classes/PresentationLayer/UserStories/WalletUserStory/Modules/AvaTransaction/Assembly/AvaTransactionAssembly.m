//
//  AvaTransactionAssembly.m
//  MyEtherWallet-iOS
//
//  Created by Collin Montag on 12/11/19.
//  Copyright © 2019 MyEtherWallet, Inc. All rights reserved.
//

@import ViperMcFlurryX;

#import "TransitioningDelegateFactory.h"

#import "AvaTransactionAssembly.h"

#import "AvaTransactionViewController.h"
#import "AvaTransactionInteractor.h"
#import "AvaTransactionPresenter.h"
#import "AvaTransactionRouter.h"

@implementation AvaTransactionAssembly

- (AvaTransactionViewController *)viewAvaTransaction {
  return [TyphoonDefinition withClass:[AvaTransactionViewController class]
                        configuration:^(TyphoonDefinition *definition) {
                          [definition injectProperty:@selector(output)
                                                with:[self presenterAvaTransaction]];
                          [definition injectProperty:@selector(moduleInput)
                                                with:[self presenterAvaTransaction]];
                          [definition injectProperty:@selector(customTransitioningDelegate)
                                                with:[self.transitioningDelegateFactory transitioningDelegateWithType:@(TransitioningDelegateBottomBackgroundedModal) cornerRadius:@16.0]];
                          [definition injectProperty:@selector(modalPresentationStyle)
                                                with:@(UIModalPresentationCustom)];
                        }];
}

- (AvaTransactionInteractor *)interactorAvaTransaction {
  return [TyphoonDefinition withClass:[AvaTransactionInteractor class]
                        configuration:^(TyphoonDefinition *definition) {
                          [definition injectProperty:@selector(output)
                                                with:[self presenterAvaTransaction]];
                        }];
}

- (AvaTransactionPresenter *)presenterAvaTransaction{
  return [TyphoonDefinition withClass:[AvaTransactionPresenter class]
                        configuration:^(TyphoonDefinition *definition) {
                          [definition injectProperty:@selector(view)
                                                with:[self viewAvaTransaction]];
                          [definition injectProperty:@selector(interactor)
                                                with:[self interactorAvaTransaction]];
                          [definition injectProperty:@selector(router)
                                                with:[self routerAvaTransaction]];
                        }];
}

- (AvaTransactionRouter *)routerAvaTransaction{
  return [TyphoonDefinition withClass:[AvaTransactionRouter class]
                        configuration:^(TyphoonDefinition *definition) {
                          [definition injectProperty:@selector(transitionHandler)
                                                with:[self viewAvaTransaction]];
                        }];
}

@end
