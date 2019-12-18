//
//  AvaTransactionInteractor.h
//  MyEtherWallet-iOS
//
//  Created by Collin Montag on 12/6/19.
//  Copyright © 2019 MyEtherWallet, Inc. All rights reserved.
//

#import "AvaTransactionInteractorInput.h"

@protocol AvaTransactionInteractorOutput;

@interface AvaTransactionInteractor : NSObject <AvaTransactionInteractorInput>

@property (nonatomic, weak) id<AvaTransactionInteractorOutput> output;

@end
