//
//  AvaTransactionViewController.h
//  MyEtherWallet-iOS
//
//  Created by Collin Montag on 11/28/19.
//  Copyright © 2019 MyEtherWallet, Inc. All rights reserved.
//

@import UIKit;

#import "AvaTransactionViewInput.h"

@protocol AvaTransactionViewOutput;

@interface AvaTransactionViewController : UIViewController <AvaTransactionViewInput>
@property (nonatomic, strong) id<AvaTransactionViewOutput> output;
@property (nonatomic, strong) id <UIViewControllerTransitioningDelegate> customTransitioningDelegate;
@end
