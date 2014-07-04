//
//  CategoryCellData.h
//  Menu
//
//  Created by Edvard on 7/4/14.
//  Copyright (c) 2014 Artak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CategoryCellData : NSObject

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *title;

- (id)initWithImage:(UIImage*)image Title:(NSString*)title;

@end
