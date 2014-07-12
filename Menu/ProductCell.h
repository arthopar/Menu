//
//  ProductCell.h
//  Menu
//
//  Created by Tigran on 7/9/14.
//  Copyright (c) 2014 Artak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDto.h"

@interface ProductCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageViewThumbnail;
@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) IBOutlet UITextView *textViewDetails;
@property (strong, nonatomic) IBOutlet UIButton *buttonOrdered;


@property (strong, nonatomic) NSURL *imageUrl;
@property (strong, nonatomic) IBOutlet UITextField *textFieldOrderedCount;

@property (strong, nonatomic) IBOutlet UIButton *buttonSnipperUp;
@property (strong, nonatomic) IBOutlet UIButton *buttonSnipperDown;

- (void) updateWithDto: (ProductDto*)productDto;
- (void) updateImageView;
- (IBAction)onProductOrderPress:(id)sender;
- (IBAction)onSnipperUp:(id)sender;
- (IBAction)onSnipperDown:(id)sender;



@end
