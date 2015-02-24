//
//  CAInsetSearchTextField.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/11/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "CAInsetSearchTextField.h"

@implementation CAInsetSearchTextField

-(CGRect)textRectForBounds:(CGRect)bounds {
    CGRect rect = [super textRectForBounds:bounds];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(-2, 40, 0, 50);
    return UIEdgeInsetsInsetRect(rect, insets);
}

-(CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect rect = [super textRectForBounds:bounds];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(-2, 40, 0, 50);
    return UIEdgeInsetsInsetRect(rect, insets);
}

@end
