//
//  CAAppearance.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/10/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "CAAppearance.h"

@implementation CAAppearance

+(void)setupUIAppearance
{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName: [[Constants defaultFont] fontWithSize:19.0f] }];
    
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];

}

@end
