//
//  DetailViewController.m
//  Menu
//
//  Created by Artak on 6/26/14.
//  Copyright (c) 2014 Artak. All rights reserved.
//

#import "ProductsViewController.h"
#import "ServerInterface.h"
#import "Constants.h"
#import "CategoryDto.h"
#import "CategoryCustomViewCell.h"
#import "UIImageView+WebCache.h"
#import "ProductCell.h"
#import "ProductDto.h"

@implementation ProductsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self decorateCategoryView];
    [self decorateTableView];
    
    _products = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; ++i) {
        [_products addObject:[[ProductDto alloc] init]];
    }
    [_tableViewProduct reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated
{

}

#pragma mark - UI decoration
- (void) decorateTableView
{
    [self.tableViewCategories setSeparatorColor:[UIColor blackColor]];
    [self.tableViewCategories setBackgroundColor:[UIColor clearColor]];
    [self.tableViewProduct setSeparatorColor:[UIColor blackColor]];
    [self.tableViewProduct setBackgroundColor:[UIColor clearColor]];
}

- (void) decorateCategoryView
{
    //Get a UIImage from the UIView
    UIBlurEffect *blureEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blureEffect];
    effectView.frame = _viewForLeft.bounds;
    [effectView setAlpha:0.8];
    [effectView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [_viewForLeft addConstraint:[NSLayoutConstraint constraintWithItem:effectView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_viewForLeft
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [_viewForLeft addConstraint:[NSLayoutConstraint constraintWithItem:effectView
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_viewForLeft
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [_viewForLeft addConstraint:[NSLayoutConstraint constraintWithItem:effectView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_viewForLeft
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [_viewForLeft addConstraint:[NSLayoutConstraint constraintWithItem:effectView
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_viewForLeft
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [_viewForLeft insertSubview:effectView belowSubview:_tableViewCategories];
}

- (UIImage *)applyBlurOnImage: (UIImage *)imageToBlur withRadius: (CGFloat)blurRadius
{
    CIImage *originalImage = [CIImage imageWithCGImage: imageToBlur.CGImage];
    CIFilter *filter = [CIFilter filterWithName: @"CIGaussianBlur" keysAndValues: kCIInputImageKey, originalImage, @"inputRadius", @(blurRadius), nil];
    CIImage *outputImage = filter.outputImage;
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef outImage = [context createCGImage: outputImage fromRect: [outputImage extent]]; return [UIImage imageWithCGImage: outImage];
}

- (IBAction)openCategories:(UIBarButtonItem *)sender {
    CGRect destination = CGRectZero;
    CGFloat offsetX;
    if (CGRectGetMaxX(_viewForLeft.frame) <= self.view.frame.origin.x) {
        offsetX = CGRectGetWidth(_viewForLeft.frame);
    } else {
        offsetX = -CGRectGetWidth(_viewForLeft.frame);
    }
    destination = CGRectOffset(_viewForLeft.frame, offsetX, 0);
    
    [UIView animateWithDuration:1
                          delay:0.1
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.5
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{_viewForLeft.frame = destination;
                         _tableViewProduct.frame = CGRectInset(_tableViewProduct.frame, offsetX, 0);
                         //_tableViewProduct.frame = CGRectOffset(_tableViewProduct.frame, offsetX, 0);

                     }
                     completion:nil];
    
}

- (IBAction)goToHomePage:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:Nil];
}

# pragma mark - Server Request


-(void) getProducts
{
    _categoryList = [[NSMutableArray alloc] init];
    
    [ServerInterface requestWithData:@"Product" parameters:nil success:^(id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *responseArray = responseObject;
            for (NSDictionary *currenCategory in responseArray) {
                CategoryDto *currentCellData = [[CategoryDto alloc] init];
                currentCellData.imagePath = [currenCategory valueForKey:@"imagePath"];
                currentCellData.imagePath = [SERVERROOT stringByAppendingString:currentCellData.imagePath];
                currentCellData.name = [currenCategory valueForKey:@"name"];
                [_categoryList addObject:currentCellData];
            }
            [_tableViewCategories reloadData];
        } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
            //NSDictionary *responseDict = responseObject;
            /* do something with responseDict */
        }
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_tableViewCategories]) {
        return [_categoryList count];
    }
    if ([tableView isEqual:_tableViewProduct]) {
        return [_products count];
    }

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_tableViewCategories]) {
    static NSString *CellIdentifier = @"CategoryCustomViewCell";
    
    CategoryCustomViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CategoryCustomViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    CategoryDto *currentCategory = [_categoryList objectAtIndex:indexPath.row];
    cell.lblTitle.text = currentCategory.name;
    [cell.imageViewCategory sd_setImageWithURL: [NSURL URLWithString:currentCategory.imagePath]];
    
    return cell;
    }
    if ([tableView isEqual:_tableViewProduct]) {
        static NSString *CellIdentifier = @"ProductCell";
        
        ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[ProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        [cell updateWithDto:[_products objectAtIndex:indexPath.row]];
        
        return cell;
    }
    
    return nil;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_tableViewCategories]) {
    CategoryCustomViewCell *categoryCustomViewCell = (CategoryCustomViewCell*)cell;
    [categoryCustomViewCell setBackgroundColor:[UIColor clearColor]];
    categoryCustomViewCell.lblTitle.textColor = [UIColor brownColor];
    [categoryCustomViewCell.imageViewCategory.layer setCornerRadius:15];
    }
    if ([tableView isEqual:_tableViewProduct]) {
        ProductCell *productCell = (ProductCell*)cell;
        [productCell setBackgroundColor:[UIColor clearColor]];
        [productCell updateImageView];
    }
}

#pragma mark - UITableViewDataSource Methods

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO
    NSLog(@"Selected row: %ld", (long)indexPath.row);
}

@end
