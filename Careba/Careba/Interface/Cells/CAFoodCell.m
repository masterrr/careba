//
//  CAFoodCell.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/17/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "CAFoodCell.h"
#import "UIImageView+AFNetworking.h"


@interface CAFoodCell ()
- (IBAction)plusButtonHit:(id)sender;
- (IBAction)minusButtonHit:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UILabel *currentCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) CAItem *item;

@end


@implementation CAFoodCell {
    NSLayoutConstraint *_xHorizontalPlusButtonConstraint;
    NSInteger currentCount;
}


-(void)setItem:(CAItem*)item {
    _item = item;
    _titleLabel.text = item.name;
    _priceLabel.text = item.priceText;
    [_imageView setImageWithURL:item.imageNSURL];
    
    NSInteger quantity = [item quantityInCard];
    if (currentCount != quantity) {
        currentCount = quantity;
        if (currentCount == 0) {
            [self reconfigureZero];
        } else {
            [self reconfigureOneOrMore];
        }
        [self updateCountLabelText];
    }
}

-(void)awakeFromNib {
    currentCount = 0;
    [self reconfigureZero];
}

-(void)updateCountLabelText {
     _currentCountLabel.text = [NSString stringWithFormat:@"%ld", (long)currentCount];
}

- (IBAction)plusButtonHit:(id)sender {
    if (++currentCount == 1) {
        [self reconfigureOneOrMore];
    } else {
        [self updateCountLabelText];
    }
    
    if (currentCount > 6) {
        [[[UIAlertView alloc] initWithTitle:@"Слишком много еды" message:@"Возможно, это слишком много" delegate:nil cancelButtonTitle:@"Нет, я съем" otherButtonTitles: nil] show];
    }
    [_delegate clickedUp:_item];
}

- (IBAction)minusButtonHit:(id)sender {
    if (--currentCount == 0) {
        [self reconfigureZero];
    } else {
        [self updateCountLabelText];
    }
    [_delegate clickedDown:_item];
}

-(void)reconfigureOneOrMore {
    [self removeConstraint:_xHorizontalPlusButtonConstraint];
    _xHorizontalPlusButtonConstraint = nil;
    
    [UIView animateWithDuration:0.2f animations:^{
        _minusButton.alpha = 1;
        _currentCountLabel.alpha = 1;
        [self layoutIfNeeded];
    }];
    
}

-(void)reconfigureZero {

    _xHorizontalPlusButtonConstraint = [NSLayoutConstraint constraintWithItem:self.plusButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f];
    _xHorizontalPlusButtonConstraint.priority = 1000;
    [self addConstraint:_xHorizontalPlusButtonConstraint];
    
    [UIView animateWithDuration:0.2f animations:^{
        _minusButton.alpha = 0;
        _currentCountLabel.alpha = 0;
        [self layoutIfNeeded];
    }];
}

@end
