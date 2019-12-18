//
//  AvaTransactionInteractor.m
//  MyEtherWallet-iOS
//
//  Created by Collin Montag on 12/7/19.
//  Copyright © 2019 MyEtherWallet, Inc. All rights reserved.
//

#import "AvaTransactionInteractor.h"

#import "AvaTransactionInteractorOutput.h"

#import "MasterTokenPlainObject.h"
#import "NetworkPlainObject.h"

@interface AvaTransactionInteractor ()
@property (nonatomic, strong) MasterTokenPlainObject *masterToken;
@end

@implementation AvaTransactionInteractor

#pragma mark - AvaTransactionInteractorInput

- (void) configureWithMasterToken:(MasterTokenPlainObject *)masterToken {
  self.masterToken = masterToken;
}

- (MasterTokenPlainObject *) obtainMasterToken {
  return self.masterToken;
}

- (void) sendRawTransactionToAddress:(NSString *)toAddress ofAsset:(NSString *)assetId ofAmount:(NSNumber *)amount {
  // 1
  NSURL *url = [NSURL URLWithString:@"https://ava.network:21015/ext/wallet"];
  NSURLSession *session = [NSURLSession sharedSession];

  // 2
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  request.HTTPMethod = @"POST";
  [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];

  // 3
  MasterTokenPlainObject *masterToken = [self obtainMasterToken];
  NSDictionary *dictionary = @{@"jsonrpc": @"2.0", @"method":@"Wallet.Send", @"params":@{@"AccountName":@"test_acct", @"Password":@"password", @"SubnetID":masterToken.fromNetworkMaster.chainID, @"AssetID":assetId, @"Amount":amount, @"To":toAddress, @"From":@[masterToken.address]}, @"id":@1};
  NSError *error = nil;
  NSData *body = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
  [request setHTTPBody:body];

  NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    NSDictionary *payload = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//    NSSet<NSString *> *subnets = payload[@"result"][@"SubnetIDs"];
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.output didCompleteTransaction];
    });
  }];

  [postDataTask resume];
}

@end
