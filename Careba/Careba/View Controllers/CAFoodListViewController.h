//
//  CAFoodListViewController.h
//  Careba
//
//  Created by Dmitry Kurilo on 12/26/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CASection.h"

typedef NS_ENUM(NSUInteger, CAFoodListVCEnum) {
    CAFoodListVCSingleMode,
    CAFoodListVCMultiMode
};

@interface CAFoodListViewController : UIViewController

@property CAFoodListVCEnum vcMode;
@property CASection *section;

@end
