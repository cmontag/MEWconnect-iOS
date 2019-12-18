//
//  AvaWalletService.h
//  MyEtherWallet-iOS
//
//  Created by Collin Montag on 11/4/19.
//  Copyright © 2019 MyEtherWallet, Inc. All rights reserved.
//

@import Foundation;

@interface AvaAsset : NSObject {
  NSString *name;
  NSNumber *balance;
}
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *balance;
@end

@interface AvaAddress : NSObject {
  NSString *address;
  NSString *subnet;
  NSSet<AvaAsset *> *assets;
}
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *subnet;
@property (nonatomic, strong) NSSet<AvaAsset *> *assets;
@end

@interface AvaAccount : NSObject {
  NSString *name;
  NSSet<AvaAddress *> *addresses;
}
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSSet<AvaAddress *> *addresses;
@end

@interface AvaWalletService : NSObject {
  NSSet<AvaAccount *> *accounts;
}
@property (nonatomic, strong) NSSet<AvaAccount *> *accounts;;
@end
