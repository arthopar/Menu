//
//  ServerInterface.m
//  Menu
//
//  Created by Edvard on 7/12/14.
//  Copyright (c) 2014 Artak. All rights reserved.
//

#import "ServerInterface.h"
#import "AFNetworking/AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "Constants.h"
#import "AFNetworking/AFURLResponseSerialization.h"


@implementation ServerInterface

+(void)requestWithData:(NSString*)data
                        parameters:(id)parameters
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:[SERVERROOT stringByAppendingString:data] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, id responseObject) {
        failure(responseObject);
    }];
}

@end
