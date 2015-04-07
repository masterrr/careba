//
//  CAFoodCell.h
//  Careba
//
//  Created by Dmitry Kurilo on 12/17/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAItem.h"

@protocol CAFoodCellDelegate <NSObject>

-(void)clickedUp:(CAItem*)item;
-(void)clickedDown:(CAItem*)item;

@end


@interface CAFoodCell : UICollectionViewCell

@property (nonatomic, assign) id<CAFoodCellDelegate> delegate;
-(void)setItem:(CAItem*)item;

@end

