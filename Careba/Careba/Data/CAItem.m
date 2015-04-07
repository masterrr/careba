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

-(NSURL*)imageNSURL {
    return [NSURL URLWithString:[Constants fullImageUrl:self.imageUrl]];
}

-(NSInteger)quantityInCard {
    return [ShopCard quantityForItem:self];
}

-(void)image:(void(^)(UIImage *image))callback {
    [[UIImageView new] setImageWithURLRequest:[NSURLRequest requestWithURL:[self imageNSURL]] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        callback(image);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        callback(nil);
    }];
}

@end
