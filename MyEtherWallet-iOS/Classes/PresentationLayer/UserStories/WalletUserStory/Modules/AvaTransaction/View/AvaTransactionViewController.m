//
//  AvaTransactionViewController.m
//  MyEtherWallet-iOS
//
//  Created by Collin Montag on 11/28/19.
//  Copyright © 2019 MyEtherWallet, Inc. All rights reserved.
//

@import MagicalRecord;

#import "AvaTransactionViewController.h"

#import "AvaTransactionViewOutput.h"

#import "AccountModelObject.h"
#import "NetworkModelObject.h"
#import "MasterTokenModelObject.h"

@interface AvaTransactionViewController ()
@property (nonatomic, weak) IBOutlet UITextField *toAddress;
@property (nonatomic, weak) IBOutlet UITextField *sendAmount;
@property (nonatomic, weak) IBOutlet UITextField *sendAsset;
@property (nonatomic, weak) IBOutlet UIButton *makeTransaction;
@property (nonatomic, weak) IBOutlet UIButton *closeButton;
@end

@implementation AvaTransactionViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

//- (void)viewWillAppear:(BOOL)animated {
//  [super viewWillAppear:animated];
//  [self.output didTriggerViewWillAppearEvent];
//}
//
//- (void)viewDidAppear:(BOOL)animated {
//  [super viewDidAppear:animated];
//}
//
//- (void)viewDidDisappear:(BOOL)animated {
//  [super viewDidDisappear:animated];
//  [self.output didTriggerViewWillDisappearEvent];
//}

- (void) setupInitialStateWithMasterToken:(MasterTokenPlainObject *)masterToken {
  self.makeTransaction.layer.cornerRadius = 10;
}

- (IBAction)closeAction:(__unused id)sender {
  [self.output closeAction];
}

- (IBAction)makeTransactionAction:(__unused UIButton *)sender {
  NSNumber *amount = [[[NSNumberFormatter alloc] init] numberFromString:self.sendAmount.text];
  [self.output makeTransactionActionToAddress:self.toAddress.text ofAsset:self.sendAsset.text ofAmount:amount];
}

- (void)setCustomTransitioningDelegate:(id<UIViewControllerTransitioningDelegate>)customTransitioningDelegate {
  _customTransitioningDelegate = customTransitioningDelegate;
  self.transitioningDelegate = customTransitioningDelegate;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
