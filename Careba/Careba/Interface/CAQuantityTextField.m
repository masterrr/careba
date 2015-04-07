//
//  CAQuantityTextField.m
//  Careba
//
//  Created by Dmitry Kurilo on 3/3/15.
//  Copyright (c) 2015 Dmitry Kurilo. All rights reserved.
//

#import "CAQuantityTextField.h"

@implementation CAQuantityTextField

-(CGRect)textRectForBounds:(CGRect)bounds {
    CGRect rect = [super textRectForBounds:bounds];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(1, 6, 1, 5);
    return UIEdgeInsetsInsetRect(rect, insets);
}

-(CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect rect = [super textRectForBounds:bounds];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(1, 6, 1, 5);
    return UIEdgeInsetsInsetRect(rect, insets);
}

@end
