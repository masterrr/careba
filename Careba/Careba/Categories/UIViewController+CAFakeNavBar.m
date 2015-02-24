//
//  UIViewController+CAFakeNavBar.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/10/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "UIViewController+CAFakeNavBar.h"

@implementation UIViewController (CAFakeNavBar)

-(void)applyFakeNavBarToView:(UIView*)view {
    UIImage *navBarBack = [UIImage imageNamed:@"NavBar"];
    UIImageView *v = [[UIImageView alloc] initWithImage:navBarBack];
    CGRect frame = v.frame;
    frame.size.height = 129.0f;
    v.frame = frame;
    v.userInteractionEnabled = false;
    [view addSubview:v];
}

@end
