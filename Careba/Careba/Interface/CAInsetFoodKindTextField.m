//
//  CAInsetFoodKindTextField.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/17/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "CAInsetFoodKindTextField.h"

@implementation CAInsetFoodKindTextField

-(CGRect)textRectForBounds:(CGRect)bounds {
    CGRect rect = [super textRectForBounds:bounds];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(2, 10, 4, 5);
    return UIEdgeInsetsInsetRect(rect, insets);
}

-(CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect rect = [super textRectForBounds:bounds];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(2, 10, 4, 5);
    return UIEdgeInsetsInsetRect(rect, insets);
}

@end
