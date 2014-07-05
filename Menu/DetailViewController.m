//
//  DetailViewController.m
//  Menu
//
//  Created by Artak on 6/26/14.
//  Copyright (c) 2014 Artak. All rights reserved.
//

#import "DetailViewController.h"
#import "PageContentViewController.h"
#import "CategoryCellData.h"

@interface DetailViewController () {
    NSArray *categoryList;
}
            
@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self retrieveCategoryList];
    [self initPageViewController];
    [self decorateCategoryView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated
{
}
#pragma mark - UI decoration

- (void) decorateCategoryView
{
    //Get a UIImage from the UIView
    UIBlurEffect *blureEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blureEffect];
    effectView.frame = _viewForLeft.bounds;
    [effectView setAlpha:0.2];
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
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    _pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self addChildViewController:_pageViewController];
    [self.view insertSubview:_pageViewController.view atIndex:0];
    [_pageViewController didMoveToParentViewController:self];
}

#pragma mark - UIPageViewControllerDataSource Methods

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (index > 3) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    NSLog(@"Index = %d", index);
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == 4) {
        return nil;
    }
    NSLog(@"Index = %d", index);
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

#pragma mark - Data retriever methods

- (void) retrieveCategoryList
{
    // TODO: For testing purpose. When the server will be available, request to server to retrieve category data instead of replace hardcoded values.
    //// Test data
    UIImage *image = [UIImage imageNamed:@"back"];
    categoryList = @[
                     [[CategoryCellData alloc] initWithImage:image Title:@"Xorovac"],
                     [[CategoryCellData alloc] initWithImage:image Title:@"Shaurma"],
                     [[CategoryCellData alloc] initWithImage:image Title:@"Pizza"],
                     [[CategoryCellData alloc] initWithImage:image Title:@"Dzuk"],
                     [[CategoryCellData alloc] initWithImage:image Title:@"Garejur"]
                     ];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [categoryList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CategoryCellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    CategoryCellData *data = [categoryList objectAtIndex:indexPath.row];
    cell.textLabel.text = data.title;
    cell.imageView.image = data.image;
    
    return cell;
}

#pragma mark - UITableViewDataSource Methods

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO
    NSLog(@"Selected row: %d", indexPath.row);
}

@end
