//
//  AddressModelObject.h
//  MyEtherWallet-iOS
//
//  Created by Collin Montag on 12/17/19.
//  Copyright © 2019 MyEtherWallet, Inc. All rights reserved.
//

#import "Address+CoreDataProperties.h"

@interface AddressModelObject : Address
// Custom logic goes here.
+ (NSString*)entityName;
@end

