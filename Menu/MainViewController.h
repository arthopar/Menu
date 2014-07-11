//
//  MainViewController.h
//  Menu
//
//  Created by Artak on 7/8/14.
//  Copyright (c) 2014 Artak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewCategory;

@property (strong, nonatomic) NSMutableArray *categoryList;

- (IBAction)selectLangAction:(UIButton *)sender;
@end
