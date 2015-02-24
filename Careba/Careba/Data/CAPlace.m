//
//  CAPlace.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/30/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "CAPlace.h"

@implementation CAPlace

+(NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{@"logoUrl":@"logo_url", @"avgSum":@"avg_sum", @"dateClose":@"date_close", @"bgUrl":@"bg_url"};
}

-(BOOL)IsFoodForPoints {
    return [self.tags containsString:@"баллы"];
}

-(BOOL)IsPromotion {
    return [self.tags containsString:@"Акция"];
}

-(NSURL*)logoNSURL {
    return [NSURL URLWithString:[Constants fullImageUrl:self.logoUrl]];
}

-(NSURL*)bgNSURL {
    return [NSURL URLWithString:[Constants fullImageUrl:self.bgUrl]];

}

@end
