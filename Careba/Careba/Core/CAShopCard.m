//
//  CAShopCard.m
//  Careba
//
//  Created by Dmitry Kurilo on 2/28/15.
//  Copyright (c) 2015 Dmitry Kurilo. All rights reserved.
//

#import "CAShopCard.h"

@implementation CAShopCard {
    NSMutableDictionary *_items;
}

+(id)sharedManager {
    static CAShopCard *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        _items = [NSMutableDictionary new];
    }
    return self;
}

-(void)setQuantity:(NSInteger)quantity ForItem:(CAItem*)item {
    [_items setObject:@(quantity) forKey:item];
}

-(NSInteger)quantityForItem:(CAItem*)item {
    if ([[_items allKeys] containsObject:item]) {
        return [[_items objectForKey:item] integerValue];
    }
    return 0;
}

-(void)addFoodItem:(CAItem*)item {
    if ([[_items allKeys] containsObject:item]) {
        NSInteger i = [[_items objectForKey:item] integerValue];
        [_items setObject:@(++i) forKey:item];
        return;
    }
    [_items setObject:@(1) forKey:item];
}

-(void)completelyRemoveFoodItem:(CAItem*)item {
    if ([[_items allKeys] containsObject:item]) {
        [_items removeObjectForKey:item];
    }
}

-(void)removeFoodItem:(CAItem*)item {
    if ([[_items allKeys] containsObject:item]) {
        NSInteger i = [ [_items objectForKey:item] integerValue];
        if (--i == 0) {
            [_items removeObjectForKey:item];
            return;
        }
        [_items setObject:@(i) forKey:item];
        return;
    }
}

-(NSInteger)countFoodItems {
    NSInteger c = 0;
    NSArray *allValues = [_items allValues];
    for (NSNumber *n in allValues) {
        c += [n integerValue];
    }
    return c;
}

-(NSInteger)grandTotal {
    NSInteger c = 0;
    NSArray *allKeys = [_items allKeys];
    for (CAItem *item in allKeys) {
        NSInteger price = [item.price integerValue];
        NSInteger quantity = [[_items objectForKey:item] integerValue];
        c += price*quantity;
    }
    return c;
}

-(void)removeAllItems {
    [_items removeAllObjects];
}

-(NSDictionary*)foodItems {
    return _items;
}

@end
