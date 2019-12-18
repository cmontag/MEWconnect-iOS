//
//  _Network.h
//
//
// DO NOT EDIT. This file is machine-generated and constantly overwritten.
//

@import Foundation;

@class AccountPlainObject;
@class MasterTokenPlainObject;
@class TokenPlainObject;

@interface _NetworkPlainObject : NSObject <NSCoding, NSCopying>

@property (nonatomic, copy, readwrite) NSNumber *active;
@property (nonatomic, copy, readwrite) NSNumber *activeIndex;
//- (MasterTokenPlainObject *)activeMaster;
//- (NSSet<TokenPlainObject *>*)activeTokens;
@property (nonatomic, copy, readwrite) NSString *chainID;

@property (nonatomic, copy, readwrite) AccountPlainObject *fromAccount;

@property (nonatomic, copy, readwrite) NSArray<MasterTokenPlainObject *> *masterArray;

@property (nonatomic, copy, readwrite) MasterTokenPlainObject *master;

@property (nonatomic, copy, readwrite) NSSet<TokenPlainObject *> *tokens;

@end
