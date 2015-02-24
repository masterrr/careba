//
//  UIViewController+Style.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/25/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "UIViewController+Style.h"

@implementation UIViewController (Style)

-(void)applyWhiteStyle {
    UINavigationBar *navBar  = self.navigationController.navigationBar;
    navBar.translucent = NO;
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],
                                   NSFontAttributeName:[[Constants defaultFont] fontWithSize:18.0f]};
    navBar.barTintColor = RGB(248, 248, 248);
    navBar.barStyle = UIBarStyleDefault;
    [SlideNavigationController sharedInstance].leftBarButtonItem.tintColor = [UIColor blueColor];
}
-(void)applyBlackStyle {
    UINavigationBar *navBar  = [SlideNavigationController sharedInstance].navigationBar;
    navBar.translucent = YES;
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                   NSFontAttributeName:[[Constants defaultFont] fontWithSize:18.0f]};
    navBar.barStyle = UIBarStyleBlackTranslucent;
    [SlideNavigationController sharedInstance].leftBarButtonItem.tintColor = [UIColor whiteColor];
}

-(void)applyBigNavBarStyle {
    UINavigationBar *navBar  = [SlideNavigationController sharedInstance].navigationBar;
    navBar.translucent = YES;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bigNavBar"]];
    
    imageView.frame = CGRectMake(0, -64.0f, self.view.frame.size.width, [UIImage imageNamed:@"bigNavBar"].size.height);
    
    [self.view addSubview:imageView];
    
                            
}

@end
