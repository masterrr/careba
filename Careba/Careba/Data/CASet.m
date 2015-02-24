//
//  CASet.m
//  Careba
//
//  Created by Dmitry Kurilo on 2/15/15.
//  Copyright (c) 2015 Dmitry Kurilo. All rights reserved.
//

#import "CASet.h"

@implementation CASet

+(NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{@"id":@"set_id",
             @"price":@"set_price",
             @"name":@"set_name",
             @"sections":@"set_sections"};
}

+(NSValueTransformer *)sectionsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:CASection.class];
}

-(NSString*)subname {
    NSMutableString *string = [NSMutableString new];
    for (CASection *sec in self.sections) {
        [string appendFormat:@"%@, ", sec.name];
    }
    return string;
}


@end
