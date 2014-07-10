//
//  ProductDto.m
//  Menu
//
//  Created by Tigran on 7/9/14.
//  Copyright (c) 2014 Artak. All rights reserved.
//

#import "ProductDto.h"

@implementation ProductDto

- (id)init
{
    self = [super init];
    if (self) {
        self.image = @"/path/to/img";
        self.title = @"title";
        self.description = @"title";
    }
    return self;
}

@end
