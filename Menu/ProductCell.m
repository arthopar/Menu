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
    self.textFieldOrderedCount.text = 0;
    
    [_textFieldOrderedCount setHidden:YES];
    [_buttonSnipperUp setHidden:YES];
    [_buttonSnipperDown setHidden:YES];

}

-(void) updateImageView
{
    [self.imageViewThumbnail sd_setImageWithURL:_imageUrl];
}

- (IBAction)onProductOrderPress:(id)sender {
    
	[_buttonOrdered setHidden:YES];
    [_textFieldOrderedCount setHidden:NO];
    [_buttonSnipperUp setHidden:NO];
    [_buttonSnipperDown setHidden:NO];

}

- (IBAction)onSnipperUp:(id)sender {

}

- (IBAction)onSnipperDown:(id)sender {
}

@end
