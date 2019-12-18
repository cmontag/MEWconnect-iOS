//
//  AvaWalletOperationFactory.m
//  MyEtherWallet-iOS
//
//  Created by Collin Montag on 11/3/19.
//  Copyright © 2019 MyEtherWallet, Inc. All rights reserved.
//

#import "AvaWalletOperationFactory.h"

#import "CompoundOperationBuilderConfig.h"
#import "NetworkingConstantsHeader.h"
#import "NetworkCompoundOperationBuilder.h"

#import "QueryTransformer.h"
#import "BodyTransformer.h"
#import "HeadersBuilder.h"

#import "RequestDataModel.h"

#import "TokenModelObject.h"
#import "MasterTokenModelObject.h"

@interface AvaWalletOperationFactory ()
@property (nonatomic, strong) NetworkCompoundOperationBuilder *networkOperationBuilder;
@property (nonatomic, strong) id <QueryTransformer> queryTransformer;
@property (nonatomic, strong) id <BodyTransformer> bodyTransformer;
@property (nonatomic, strong) id <HeadersBuilder> headersBuilder;
@end

@implementation AvaWalletOperationFactory

#pragma mark - Initialization

- (instancetype)initWithBuilder:(NetworkCompoundOperationBuilder *)builder
               queryTransformer:(id<QueryTransformer>)queryTransformer
                bodyTransformer:(id<BodyTransformer>)bodyTransformer
                 headersBuilder:(id<HeadersBuilder>)headersBuilder {
  self = [super init];
  if (self) {
    _networkOperationBuilder = builder;
    _queryTransformer = queryTransformer;
    _bodyTransformer = bodyTransformer;
    _headersBuilder = headersBuilder;
  }
  return self;
}

#pragma mark - Operations creation

- (CompoundOperationBase *) subnetList:(MasterTokenBody *)body {
  CompoundOperationBuilderConfig *config = [[CompoundOperationBuilderConfig alloc] init];
  
  config.requestConfigurationType = RequestConfigurationAvaAPIType;
  config.requestMethod = kHTTPMethodPOST;
  config.serviceName = kServiceNameAVA;
  
  config.responseDeserializationType = ResponseDeserializationJSONType;
  
  config.responseConvertingType = ResponseConvertingDefaultType;
  
  config.responseValidationType = ResponseValidationDisabledType;
  
  config.responseMappingType = ResponseMappingCoreDataType;
  
  config.mappingContext = @{kMappingContextModelClassKey : NSStringFromClass([MasterTokenModelObject class])};
  
  NSData *bodyData = [self.bodyTransformer deriveDataFromBody:body];
  NSDictionary *headers = [self.headersBuilder build];
  RequestDataModel *inputData = [[RequestDataModel alloc] initWithHTTPHeaderFields:headers
                                                                   queryParameters:nil
                                                                          bodyData:bodyData];
  config.inputQueueData = inputData;
  return [self.networkOperationBuilder buildCompoundOperationWithConfig:config];
}

@end
