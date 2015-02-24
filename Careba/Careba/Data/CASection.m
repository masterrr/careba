//
//  CASection.m
//  Careba
//
//  Created by Dmitry Kurilo on 2/15/15.
//  Copyright (c) 2015 Dmitry Kurilo. All rights reserved.
//

#import "CASection.h"
#import "CAItem.h"

@implementation CASection

+(NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{@"id":@"section_id",
             @"name":@"section_name"};
}

+(NSValueTransformer *)itemsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:CAItem.class];
}

@end
