//
//  CategoryCellData.m
//  Menu
//
//  Created by Edvard on 7/4/14.
//  Copyright (c) 2014 Artak. All rights reserved.
//

#import "CategoryCellData.h"

@implementation CategoryCellData

- (id)initWithImage:(UIImage*)image Title:(NSString*)title
{
    self = [super init];
    if (self) {
        self.image = image;
        self.title = title;
    }
    return self;
}

@end
