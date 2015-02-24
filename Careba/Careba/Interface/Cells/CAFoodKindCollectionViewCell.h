//
//  CAFoodKindCollectionViewCell.h
//  Careba
//
//  Created by Dmitry Kurilo on 12/11/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAFoodKindCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *foodImage;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
