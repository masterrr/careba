//
//  CAInsetCafeFeatureTextField.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/11/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "CAInsetCafeFeatureTextField.h"

@implementation CAInsetCafeFeatureTextField

-(CGRect)textRectForBounds:(CGRect)bounds {
    CGRect rect = [super textRectForBounds:bounds];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 5, 0, 0);
    return UIEdgeInsetsInsetRect(rect, insets);
}

-(CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect rect = [super textRectForBounds:bounds];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 5, 0, 0);
    return UIEdgeInsetsInsetRect(rect, insets);
}

@end
