//
//  CAPlaceKindCollectionViewCell.h
//  Careba
//
//  Created by Dmitry Kurilo on 12/17/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAInsetFoodKindTextField.h"

@interface CAPlaceKindCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet CAInsetFoodKindTextField *textField;


+(UIFont*)usedFontForSelectedState:(BOOL)selected;
-(void)setTitle:(NSString*)title;

@end
