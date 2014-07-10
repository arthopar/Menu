//
//  DetailViewController.m
//  Menu
//
//  Created by Artak on 6/26/14.
//  Copyright (c) 2014 Artak. All rights reserved.
//

#import "ProductsViewController.h"
#import "ProductPageViewController.h"
#import "AFNetworking/AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "Constants.h"
#import "AFNetworking/AFURLResponseSerialization.h"
#import "CategoryDto.h"
#import "CategoryCustomViewCell.h"
#import "UIImageView+WebCache.h"


@implementation ProductsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self initPageViewController];
    [self decorateCategoryView];
    [self decorateTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated
{
    [self getCategories];
}
#pragma mark - UI decoration
- (void) decorateTableView
{
    [self.tableViewCategories setSeparatorColor:[UIColor blackColor]];
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

#pragma mark - UIPageViewController

-(void) initPageViewController
{
    _pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    
    _pageViewController.dataSource = self;
    
    ProductPageViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    _pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self addChildViewController:_pageViewController];
    [self.view insertSubview:_pageViewController.view atIndex:0];
    [_pageViewController didMoveToParentViewController:self];
}

#pragma mark - UIPageViewControllerDataSource Methods

- (ProductPageViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (index > 3) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    ProductPageViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((ProductPageViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    NSLog(@"Index = %lu", (unsigned long)index);
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((ProductPageViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == 4) {
        return nil;
    }
    NSLog(@"Index = %lu", (unsigned long)index);
    return [self viewControllerAtIndex:index];
}

//#pragma mark - UIPageViewControllerDelegate Methods
//
//- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController
//                   spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
//    
//    UIViewController *currentViewController = [_pageViewController.viewControllers objectAtIndex:0];
//    NSArray *viewControllers = [NSArray arrayWithObject:currentViewController];
//    [pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
//    
//    _pageViewController.doubleSided = NO;
//    
//    return UIPageViewControllerSpineLocationMin;
//    
//}

- (IBAction)openCategories:(UIBarButtonItem *)sender {
    CGRect destination = CGRectZero;
    if (CGRectGetMaxY(_viewForLeft.frame) < self.view.center.y) {
        destination = CGRectOffset(_viewForLeft.frame, 0, CGRectGetHeight(_viewForLeft.frame));
    } else {
        destination = CGRectOffset(_viewForLeft.frame, 0, -CGRectGetHeight(_viewForLeft.frame));
    }
    [UIView animateWithDuration:1
                          delay:0.1
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.5
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{_viewForLeft.frame = destination;}
                     completion:nil];
    
}

- (IBAction)goToHomePage:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:Nil];
}

# pragma mark - Server Request

-(void) getCategories
{
    _categoryList = [[NSMutableArray alloc] init];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:[SERVERROOT stringByAppendingString:@"Category"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
            NSDictionary *responseDict = responseObject;
            /* do something with responseDict */
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void) getProducts
{
    _categoryList = [[NSMutableArray alloc] init];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:[SERVERROOT stringByAppendingString:@"Product"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
            NSDictionary *responseDict = responseObject;
            /* do something with responseDict */
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_categoryList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryCustomViewCell *categoryCustomViewCell = (CategoryCustomViewCell*)cell;
    [categoryCustomViewCell setBackgroundColor:[UIColor clearColor]];
    categoryCustomViewCell.lblTitle.textColor = [UIColor brownColor];
    [categoryCustomViewCell.imageViewCategory.layer setCornerRadius:15];
     
}

#pragma mark - UITableViewDataSource Methods

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO
    NSLog(@"Selected row: %ld", (long)indexPath.row);
}

@end
