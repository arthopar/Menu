//
//  ProductCell.m
//  Menu
//
//  Created by Tigran on 7/9/14.
//  Copyright (c) 2014 Artak. All rights reserved.
//

#import "ProductCell.h"
#import "ProductDto.h"

@implementation ProductCell

- (ProductCell*) updateWithDto: (ProductDto*)productDto
{
    ProductCell *cell;
    cell.labelTitle.text = productDto.title; // senc lriv init ara celly
    cell.imageViewThumbnail = [[UIImageView alloc] init]; // productDto.image
    cell.textViewDetails.text = productDto.description;
    cell.buttonOrdered = [[UIButton alloc] init];
    cell.stepperOrderedProductCount = 0;
    return cell;
}

@end
