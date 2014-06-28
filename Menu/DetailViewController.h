//
//  DetailViewController.h
//  Menu
//
//  Created by Artak on 6/26/14.
//  Copyright (c) 2014 Artak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@end

