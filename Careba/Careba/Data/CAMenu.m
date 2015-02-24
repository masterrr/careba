//
//  CAMenu.m
//  Careba
//
//  Created by Dmitry Kurilo on 2/15/15.
//  Copyright (c) 2015 Dmitry Kurilo. All rights reserved.
//

#import "CAMenu.h"
#import "CASection.h"
#import "CASet.h"

@implementation CAMenu

+(NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{@"id":@"menu_id",
             @"active":@"menu_active",
             @"name":@"menu_name",
             @"hours":@"hours_work_places"};
}

+(NSValueTransformer *)sectionsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:CASection.class];
}

+(NSValueTransformer *)setsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:CASet.class];
}

@end
