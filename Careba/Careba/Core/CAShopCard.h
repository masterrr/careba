//
//  CAShopCard.h
//  Careba
//
//  Created by Dmitry Kurilo on 2/28/15.
//  Copyright (c) 2015 Dmitry Kurilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CAItem.h"

typedef NS_ENUM(NSUInteger, CAShopPickupKind) {
    CAShopPickupKindEatingAtThePlace,
    CAShopPickupKindPack
};

typedef NS_ENUM(NSUInteger, CAShopPickupTimeMode) {
    CAShopPickupTimeModeASAP,
    CAShopPickupTimeModeSpecifyMinutes
};


#define ShopCard [CAShopCard sharedManager]

@interface CAShopCard : NSObject

+(id)sharedManager;

@property CAShopPickupKind pickupKind;
@property CAShopPickupTimeMode pickupTimeMode;
@property NSInteger minutes;

-(void)setQuantity:(NSInteger)quantity ForItem:(CAItem*)item;
-(NSInteger)quantityForItem:(CAItem*)item;
-(void)addFoodItem:(CAItem*)item;

-(void)completelyRemoveFoodItem:(CAItem*)item;
-(void)removeFoodItem:(CAItem*)item;

-(NSInteger)countFoodItems;
-(NSInteger)grandTotal;
-(void)removeAllItems;

-(NSDictionary*)foodItems;

@end
