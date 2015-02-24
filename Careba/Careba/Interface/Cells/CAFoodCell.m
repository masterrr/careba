//
//  CAFoodCell.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/17/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "CAFoodCell.h"

@interface CAFoodCell ()
- (IBAction)plusButtonHit:(id)sender;
- (IBAction)minusButtonHit:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UILabel *currentCountLabel;

@end

@implementation CAFoodCell {
    NSLayoutConstraint *_xHorizontalPlusButtonConstraint;
    NSInteger currentCount;
}

-(void)awakeFromNib {
    currentCount = 1;
}

- (IBAction)plusButtonHit:(id)sender {
    if (++currentCount == 1) {
        [self reconfigureOneOrMore];
    } else {
        _currentCountLabel.text = [NSString stringWithFormat:@"%ld", (long)currentCount];
    }
    
    if (currentCount > 6) {
        [[[UIAlertView alloc] initWithTitle:@"WOW SUCH FOOD" message:@"A LOT OF FOOD YOU'VE CHOSEN MY FRIEND" delegate:nil cancelButtonTitle:@"That's alright" otherButtonTitles: nil] show];
    }
}

- (IBAction)minusButtonHit:(id)sender {
    if (--currentCount == 0) {
        [self reconfigureZero];
    } else {
        _currentCountLabel.text = [NSString stringWithFormat:@"%ld", (long)currentCount];
    }
    

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
