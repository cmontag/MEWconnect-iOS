//
//  AvaWalletOperationFactory.h
//  MyEtherWallet-iOS
//
//  Created by Collin Montag on 11/3/19.
//  Copyright © 2019 MyEtherWallet, Inc. All rights reserved.
//

@import Foundation;

#import "BlockchainNetworkTypes.h"

@class CompoundOperationBase;
@class NetworkCompoundOperationBuilder;

@protocol QueryTransformer;
@protocol BodyTransformer;
@protocol HeadersBuilder;

@class TokensBody;
@class MasterTokenBody;

@interface AvaWalletOperationFactory : NSObject
- (instancetype)initWithBuilder:(NetworkCompoundOperationBuilder *)builder
               queryTransformer:(id<QueryTransformer>)queryTransformer
                bodyTransformer:(id<BodyTransformer>)bodyTransformer
                 headersBuilder:(id<HeadersBuilder>)headersBuilder;
- (CompoundOperationBase *) subnetList:(TokensBody *)body;
@end
