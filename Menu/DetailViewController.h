//
//  DetailViewController.h
//  Menu
//
//  Created by Artak on 6/26/14.
//  Copyright (c) 2014 Artak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) UIViewController *contentViewController;
@end

