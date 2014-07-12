//
//  ProductCell.m
//  Menu
//
//  Created by Tigran on 7/9/14.
//  Copyright (c) 2014 Artak. All rights reserved.
//

#import "ProductCell.h"
#import "ProductDto.h"
#import "UIImageView+WebCache.h"

@implementation ProductCell

-(void) updateWithDto: (ProductDto*)productDto
{
    self.labelTitle.text = productDto.title;
    self.imageUrl = [NSURL URLWithString: productDto.image];
    self.textViewDetails.text = productDto.description;
    self.buttonOrdered = [[UIButton alloc] init];
    self.stepperOrderedProductCount = 0;
}

-(void) updateImageView
{
    [self.imageViewThumbnail sd_setImageWithURL:_imageUrl];
}
@end
