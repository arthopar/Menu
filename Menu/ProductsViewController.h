//
//  DetailViewController.h
//  Menu
//
//  Created by Artak on 6/26/14.
//  Copyright (c) 2014 Artak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductsViewController : UIViewController <UIPageViewControllerDataSource, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonCategories;
@property (weak, nonatomic) IBOutlet UITableView *tableViewCategories;
@property (weak, nonatomic) IBOutlet UIView *viewForLeft;

@property (strong, nonatomic) UIPageViewController *pageViewController;

- (IBAction)openCategories:(UIBarButtonItem *)sender;
@end

