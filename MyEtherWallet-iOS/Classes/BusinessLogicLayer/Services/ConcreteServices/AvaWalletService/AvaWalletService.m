//
//  AvaWalletService.m
//  MyEtherWallet-iOS
//
//  Created by Collin Montag on 11/16/19.
//  Copyright © 2019 MyEtherWallet, Inc. All rights reserved.
//

#import "AvaWalletService.h"

@implementation AvaAsset

@synthesize name;
@synthesize balance;

- (id) init:(NSString *)name withBalance:(NSNumber *)balance {
  if (self = [super init]) {
    self.name = name;
    self.balance = balance;
  }
  return self;
}

@end

@implementation AvaAddress

@synthesize address;
@synthesize subnet;
@synthesize assets;

- (id) init:(NSString *)address onSubnet:(NSString *)subnet {
  if (self = [super init]) {
    self.address = address;
    self.subnet = subnet;
    self.assets = [[NSSet alloc] init];
  }
  return self;
}

@end

@implementation AvaAccount

@synthesize name;
@synthesize addresses;

- (id) init:(NSString *)name {
  if (self = [super init]) {
    self.name = name;
    self.addresses = [[NSSet alloc] init];
  }
  return self;
}

@end

@implementation AvaWalletService

@synthesize accounts;

- (id) init {
  if (self = [super init]) {
    self.accounts = [[NSSet alloc] init];
  }
  return self;
}

@end
