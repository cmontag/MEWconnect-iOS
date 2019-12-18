//
//  NewWalletInteractor.m
//  MyEtherWallet-iOS
//
//  Created by Mikhail Nikanorov on 28/04/2018.
//  Copyright © 2018 MyEtherWallet, Inc. All rights reserved.
//

@import libextobjc.EXTScope;

#import "NewWalletInteractor.h"

#import "NewWalletInteractorOutput.h"

#import "MEWConnectFacade.h"
#import "AccountsService.h"
#import "AvaWalletService.h"
#import "TokensService.h"
#import "KeychainService.h"
#import "BlockchainNetworkService.h"
#import "MEWwallet.h"
#import "Ponsomizer.h"

#import "NetworkPlainObject.h"
#import "AccountPlainObject.h"
#import "MasterTokenPlainObject.h"

@interface NewWalletInteractor ()
@end

@implementation NewWalletInteractor

#pragma mark - NewWalletInteractorInput

- (void) createNewWalletWithPassword:(NSString *)password words:(NSArray<NSString *> *)words {
  [self.connectFacade disconnect];
  
  [self.accountsService resetAccounts];
  [self.tokensService resetTokens];
  [self.keychainService resetKeychain];
  
  AvaAccount *account = [[AvaAccount alloc] init];
  AvaAddress *address1 = [[AvaAddress alloc] init];
  address1.address = @"12345";
  address1.subnet = @"Test Subnet";
  AvaAddress *address2 = [[AvaAddress alloc] init];
  address2.address = @"P5wdRuZeaDt28eHMP5S3w9ZdoBfo7wuzF";
  address2.subnet = @"1111111115anqnRpqE8TqKvbEVusZvK1fgwqocvxkfMPV7";
  AvaAddress *address3 = [[AvaAddress alloc] init];
  address3.address = @"24680";
  address3.subnet = @"Test Subnet";
  NSSet *testAddresses = [NSSet setWithObjects:address1, address2, address3, nil];
  account.addresses = testAddresses;
  [self _createNewWalletWithPassword:password words:words account:account];
//  [self _initSubnetForAccount:account password:password words:words];
}

- (void) _createNewWalletWithPassword:(NSString *)password words:(NSArray<NSString *> *)words account:(AvaAccount *)avaAccount {
  AccountModelObject *accountModelObject = [self.accountsService obtainOrCreateActiveAccount];
  NSArray *ignoringProperties = @[NSStringFromSelector(@selector(tokens))];
  AccountPlainObject *account = [self.ponsomizer convertObject:accountModelObject ignoringProperties:ignoringProperties];
  
//  NSSet *chainIDs = [NSSet setWithObjects:@(BlockchainNetworkTypeAva), nil];
  @weakify(self);
  [self.mewWallet createKeysForAvaAccount:avaAccount forAccount:account withPassword:password mnemonicWords:words completion:^(__unused BOOL success) {
    @strongify(self);
    
    AccountModelObject *accountModelObject = [self.accountsService obtainOrCreateActiveAccount];
    NSArray *ignoringProperties = @[NSStringFromSelector(@selector(tokens))];
    AccountPlainObject *account = [self.ponsomizer convertObject:accountModelObject ignoringProperties:ignoringProperties];
    
    [self.accountsService accountBackedUp:account];
    if (words) {
      [self.accountsService accountBackedUp:account];
    }
    
    NetworkPlainObject *mainnetNetwork = [account.networks anyObject];
    [self.blockchainNetworkService selectNetwork:mainnetNetwork inAccount:account];
  }];
}

- (void) _initSubnetForAccount:(AvaAccount *)account password:(NSString *)password words:(NSArray<NSString *> *)words {
  // 1
  NSURL *url = [NSURL URLWithString:@"https://ava.network:21015/ext/wallet"];
  NSURLSession *session = [NSURLSession sharedSession];

  // 2
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  request.HTTPMethod = @"POST";
  [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];

  // 3
  NSDictionary *dictionary = @{@"jsonrpc": @"2.0", @"method":@"Wallet.ListSubnets", @"params":@[], @"id":@1};
  NSError *error = nil;
  NSData *body = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
  [request setHTTPBody:body];

  NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    NSDictionary *payload = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSSet<NSString *> *subnets = payload[@"result"][@"SubnetIDs"];
    dispatch_async(dispatch_get_main_queue(), ^{
      [self _initAddressesForAccount:account withSubnetList:subnets password:password words:words];
    });
  }];

  [postDataTask resume];
}

- (void) _initAddressesForAccount:(AvaAccount *)account withSubnetList:(NSSet<NSString *> *)subnetList password:(NSString *)password words:(NSArray<NSString *> *)words {
  // 1
  NSURL *url = [NSURL URLWithString:@"https://ava.network:21015/ext/wallet"];
  NSURLSession *session = [NSURLSession sharedSession];

  // 2
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  request.HTTPMethod = @"POST";
  [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
  
  dispatch_group_t group = dispatch_group_create();
  __block NSMutableSet *addressSet = [[NSMutableSet alloc] init];
  for (NSString *subnetID in subnetList) {
    dispatch_group_enter(group);
    // 3
    NSDictionary *dictionary = @{@"jsonrpc": @"2.0", @"method":@"Wallet.ListAddresses", @"params":@{@"AccountName":@"test_acct", @"SubnetID":subnetID}, @"id":@1};
    NSError *error = nil;
    NSData *body = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
    [request setHTTPBody:body];

    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
      NSDictionary *payload = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
      NSSet<NSString *> *addresses = payload[@"result"][@"Addresses"];
      for (NSString *address in addresses) {
        AvaAddress *addressWrapper = [[AvaAddress alloc] init];
        addressWrapper.address = address;
        addressWrapper.subnet = subnetID;
        [addressSet addObject:addressWrapper];
      }
      dispatch_group_leave(group);
    }];

    [postDataTask resume];
  }
  dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
  account.addresses = addressSet;
  [self _createNewWalletWithPassword:password words:words account:account];
}

@end
