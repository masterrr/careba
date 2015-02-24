//
//  CAPlaceKindCollectionViewCell.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/17/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "CAPlaceKindCollectionViewCell.h"

@implementation CAPlaceKindCollectionViewCell

-(void)setTitle:(NSString*)title {
    _textField.text = title;
    [_textField sizeToFit];
    [self.contentView layoutSubviews];
}


+(UIFont*)usedFontForSelectedState:(BOOL)selected {
    return selected ? [UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0f] : [[Constants defaultFont] fontWithSize:18.0f];
}

-(void)setSelected:(BOOL)selected {
    _textField.font = [CAPlaceKindCollectionViewCell usedFontForSelectedState:selected];
    _textField.background = selected ? [UIImage imageNamed:@"placeKindBackground"] : nil;
    _textField.textColor = selected ? RGB(0, 103, 255) : RGB(0, 0, 0);
    [_textField sizeToFit];

    [self.contentView layoutSubviews];
}

@end
