//
//  CAMenuCell.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/22/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "CAMenuCell.h"

@interface CAMenuCell ()

@end

@implementation CAMenuCell

-(void)awakeFromNib {
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = RGBA(0, 0, 0, 0.2f);
    [self setSelectedBackgroundView:bgColorView];
}

@end
