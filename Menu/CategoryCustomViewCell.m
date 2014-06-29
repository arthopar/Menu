//
//  CustomViewCell.m
//  Menu
//
//  Created by Edvard on 6/29/14.
//  Copyright (c) 2014 Artak. All rights reserved.
//

#import "CategoryCustomViewCell.h"

@implementation CategoryCustomViewCell

@synthesize lblTitle;
@synthesize lblSubTitle;
@synthesize imageView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
