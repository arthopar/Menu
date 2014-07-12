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
    self.buttonSnipperUp = [[UIButton alloc] init];
    self.buttonSnipperDown = [[UIButton alloc] init];
    self.textFieldOrderedCount = [[UITextField alloc] init];
    self.textFieldOrderedCount.text = 0;
    
//    self.textFieldOrderedCount.hidden=YES;
//	self.buttonSnipperUp.hidden=YES;
//	self.buttonSnipperDown.hidden=YES;
}

-(void) updateImageView
{
    [self.imageViewThumbnail sd_setImageWithURL:_imageUrl];
}

- (IBAction)onProductOrderPress:(id)sender {
    
    UIButton* buttonOrdered = (UIButton *)sender;
    
	[buttonOrdered setHidden:YES];
//    [textFieldOrderedCount setHidden:NO];
//    [buttonSnipperUp setHidden:NO];
//    [buttonSnipperDown setHidden:NO];
//
//	UIView *layer = [buttonOrdered superview];
//    ProductCell *cell = (ProductCell*)[(UIView *)layer superview];
//    [cell.textFieldOrderedCount setHidden:NO];
//    [cell.buttonSnipperUp setHidden:NO];
//    [cell.buttonSnipperDown setHidden:NO];
//    cell.buttonOrdered.frame = CGRectMake(100, 10, 100, 100);

}

- (IBAction)onSnipperUp:(id)sender {

}

- (IBAction)onSnipperDown:(id)sender {
}

@end
