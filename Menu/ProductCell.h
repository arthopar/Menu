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
@property (strong, nonatomic) IBOutlet UIStepper *stepperOrderedProductCount;

@property (strong, nonatomic) NSURL *imageUrl;

- (void) updateWithDto: (ProductDto*)productDto;
- (void) updateImageView;
@end
