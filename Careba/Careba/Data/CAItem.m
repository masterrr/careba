//
//  CAItem.m
//  Careba
//
//  Created by Dmitry Kurilo on 2/15/15.
//  Copyright (c) 2015 Dmitry Kurilo. All rights reserved.
//

#import "CAItem.h"

@implementation CAItem

+(NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{@"priceText":@"price_text",
             @"descr":@"description",
             @"imageUrl":@"image_url"};
}

@end
