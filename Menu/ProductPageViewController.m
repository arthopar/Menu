//
//  PageContentViewController.m
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "ProductPageViewController.h"
#import "ProductCell.h"
#import "ProductDto.h"

@interface ProductPageViewController ()

@end

@implementation ProductPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    _products = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; ++i) {
        [_products addObject:[[ProductDto alloc] init]];
    }
    [_tableViewProduct reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProductCell";
    
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell updateWithDto:[_products objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{/*
    CategoryCustomViewCell *categoryCustomViewCell = (CategoryCustomViewCell*)cell;
    [categoryCustomViewCell setBackgroundColor:[UIColor clearColor]];
    categoryCustomViewCell.lblTitle.textColor = [UIColor brownColor];
    [categoryCustomViewCell.imageViewCategory.layer setCornerRadius:15];
  */
}

#pragma mark - UITableViewDataSource Methods

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO
    NSLog(@"Selected row: %d", indexPath.row);
}

@end
