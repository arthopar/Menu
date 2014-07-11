//
//  DetailViewController.h
//  Menu
//
//  Created by Artak on 6/26/14.
//  Copyright (c) 2014 Artak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonCategories;
@property (weak, nonatomic) IBOutlet UITableView *tableViewCategories;
@property (weak, nonatomic) IBOutlet UIView *viewForLeft;
@property (weak, nonatomic) IBOutlet UITableView *tableViewProduct;

//@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSMutableArray *categoryList;
@property (strong, nonatomic) NSMutableArray *products;
//@property (strong, nonatomic)  ProductPageViewController *productPagetViewController;
- (IBAction)openCategories:(UIBarButtonItem *)sender;
- (IBAction)goToHomePage:(UIBarButtonItem *)sender;
@end

