//
//  CAFoodCell.h
//  Careba
//
//  Created by Dmitry Kurilo on 12/17/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CAFoodCellCellDelegate;

@interface CAFoodCell : UICollectionViewCell

@property (nonatomic, assign) id<CAFoodCellCellDelegate> delegate;


@end

@protocol CAFoodCellDelegate <NSObject>

@end
