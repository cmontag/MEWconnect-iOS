//
//  AccountPlainObject.h
//
//

#import "_AccountPlainObject.h"

#import "BlockchainNetworkTypes.h"

@interface AccountPlainObject : _AccountPlainObject
- (NetworkPlainObject *) networkForNetworkType:(NSString *)networkType;
- (BOOL) isEqualToAccount:(AccountPlainObject *)account;
@end
