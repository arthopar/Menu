//
//  ServerInterface.h
//  Menu
//
//  Convenient interface for requesting to the server.
//
//  Created by Edvard on 7/12/14.
//  Copyright (c) 2014 Artak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerInterface : NSObject

+ (void)requestWithData:(NSString*)data
                        parameters:(id)parameters
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error))failure;

@end
