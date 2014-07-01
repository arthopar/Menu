//
//  PageContentViewController.h
//  PageViewDemo
//
//  Created by Arta on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController
@property NSUInteger pageIndex;
@property NSString *titleText;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewBackground;

@end
