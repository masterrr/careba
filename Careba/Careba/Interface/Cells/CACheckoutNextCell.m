//
//  CACheckoutNextCell.m
//  Careba
//
//  Created by Dmitry Kurilo on 3/9/15.
//  Copyright (c) 2015 Dmitry Kurilo. All rights reserved.
//

#import "CACheckoutNextCell.h"

@interface CACheckoutNextCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tickLabelConstraint;

@end


@implementation CACheckoutNextCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTickHidden:(BOOL)hidden {
    _tickImageView.hidden = hidden;
    _tickLabelConstraint.constant = hidden ? -24.0f : 10.0f;
    [self.contentView setNeedsLayout];
}

@end
