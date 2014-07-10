//
//  PageContentViewController.h
//  PageViewDemo
//
//  Created by Artak on 6/26/14.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductPageViewController : UIViewController
@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSMutableArray *products;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewBackground;
@property (weak, nonatomic) IBOutlet UITableView *tableViewProduct;

@end
