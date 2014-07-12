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
        self.image = @"http://a57.foxnews.com/global.fncstatic.com/static/managed/img/U.S./876/493/neopolitan_pizza.jpg?ve=1&tl=1";
        self.title = @"title";
        self.description = @"Descr";
    }
    return self;
}

@end
