//
//  AvaTransactionPresenter.h
//  MyEtherWallet-iOS
//
//  Created by Collin Montag on 12/6/19.
//  Copyright © 2019 MyEtherWallet, Inc. All rights reserved.
//

#import "AvaTransactionViewOutput.h"
#import "AvaTransactionInteractorOutput.h"
#import "AvaTransactionModuleInput.h"

@protocol AvaTransactionViewInput;
@protocol AvaTransactionInteractorInput;
@protocol AvaTransactionRouterInput;

@interface AvaTransactionPresenter : NSObject <AvaTransactionModuleInput, AvaTransactionViewOutput, AvaTransactionInteractorOutput>

@property (nonatomic, weak) id<AvaTransactionViewInput> view;
@property (nonatomic, strong) id<AvaTransactionInteractorInput> interactor;
@property (nonatomic, strong) id<AvaTransactionRouterInput> router;

@end
