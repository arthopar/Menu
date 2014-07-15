//
//  MainViewController.m
//  Menu
//
//  Created by Artak on 7/8/14.
//  Copyright (c) 2014 Artak. All rights reserved.
//

#import "MainViewController.h"
#import "CategoryCollectionViewCell.h"
#import "Constants.h"
#import "ServerInterface.h"
#import "CategoryDto.h"
#import "UIImageView+WebCache.h"
#import "ProductsViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    UIImage *a = [UIImage imageNamed:@"drink"];
//    _categories = @[[UIImage imageNamed:@"drink"],
//                    [UIImage imageNamed:@"beer"],
//                    [UIImage imageNamed:@"desert"],
//                    [UIImage imageNamed:@"stake"],
//                    [UIImage imageNamed:@"pizza"]];
    // Do any additional setup after loading the view.
    [self getCategories];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getCategories
{
    _categoryList = [[NSMutableArray alloc] init];
  
    CategoryDto *currentCellData = [[CategoryDto alloc] init];
    currentCellData.imagePath = @"golf7.png";
    currentCellData.name = @"Golf-7";
    [_categoryList addObject:currentCellData];

    currentCellData = [[CategoryDto alloc] init];
    currentCellData.imagePath = @"cx7.png";
    currentCellData.name = @"CX-7";
    [_categoryList addObject:currentCellData];
    
//    [ServerInterface requestWithData:@"Category" parameters:nil success:^(id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//        if ([responseObject isKindOfClass:[NSArray class]]) {
//            NSArray *responseArray = responseObject;
//            for (NSDictionary *currenCategory in responseArray) {
//                CategoryDto *currentCellData = [[CategoryDto alloc] init];
//                currentCellData.imagePath = [currenCategory valueForKey:@"imagePath"];
//                currentCellData.imagePath = [SERVERROOT stringByAppendingString:currentCellData.imagePath];
//                currentCellData.name = [currenCategory valueForKey:@"name"];
//                [_categoryList addObject:currentCellData];
//            }
//            [_collectionViewCategory reloadData];
//        } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            //NSDictionary *responseDict = responseObject;
//            /* do something with responseDict */
//        }
//    } failure:^(NSError *error) {
//        
//        NSLog(@"Error: %@", error);
//    }];
}
#pragma mark collection view source

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoryCollectionViewCell *cell = (CategoryCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCollectionViewCell" forIndexPath:indexPath];
    CategoryDto *currentCategoryItem = _categoryList[indexPath.row];

//  NSURL *imageUrl = [NSURL URLWithString: currentCategoryItem.imagePath];
//	NSURL *imageUrl = [NSURL URLWithString: currentCategoryItem.imagePath];
//  [cell.imageView sd_setImageWithURL:imageUrl];
    [cell.imageView setImage:[UIImage imageNamed:currentCategoryItem.imagePath] ];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductsViewController *productsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductsViewController"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:productsViewController];
    productsViewController.categoryList = _categoryList;
    [self presentViewController:nav animated:YES completion:nil];
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(160, 160);
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_categoryList count];
}

- (IBAction)selectLangAction:(UIButton *)sender {
}
@end
