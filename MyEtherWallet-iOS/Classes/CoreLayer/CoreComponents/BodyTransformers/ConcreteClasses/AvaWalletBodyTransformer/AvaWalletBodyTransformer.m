//
//  AvaWalletBodyTransformer.m
//  MyEtherWallet-iOS
//
//  Created by Collin Montag on 11/4/19.
//  Copyright © 2019 MyEtherWallet, Inc. All rights reserved.
//

#if BETA
#import "MyEtherWallet_iOS_Beta-Swift.h"
#else
#import "MyEtherWallet_iOS-Swift.h"
#endif
#import "AvaWalletBodyTransformer.h"

#import "TokensBody.h"
#import "MasterTokenBody.h"

@implementation AvaWalletBodyTransformer

- (NSData *) deriveDataFromBody:(id)body {
  if ([body isKindOfClass:[TokensBody class]]) {
    return [Web3Wrapper listSubnetsRequest];
  } else if ([body isKindOfClass:[MasterTokenBody class]]) {
    return [Web3Wrapper listSubnetsRequest];
  }
  return nil;
}

@end
