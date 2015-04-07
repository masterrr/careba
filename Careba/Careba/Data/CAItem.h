//
//  CAItem.h
//  Careba
//
//  Created by Dmitry Kurilo on 2/15/15.
//  Copyright (c) 2015 Dmitry Kurilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>
#import "UIImageView+AFNetworking.h"

//"id": "329",
//"name": "Мясное плато на компанию",
//"price": 1350,
//"price_text": "1350 р.",
//"description": "Большое разнообразие мясных деликатесов высочайшего качества: свиные ребрышки, охотничьи колбаски, крылья барбекю, крылья копченые, крылья чили. Подается с тремя соусами. 1000гр.  ",
//"image_url": "\/images\/cafe\/4\/43\/329\/0.jpg",
//"count": 0

@interface CAItem : MTLModel<MTLJSONSerializing>

@property NSNumber *id;
@property NSString *name;
@property NSNumber *price;
@property NSString *priceText;
@property NSString *descr;
@property NSString *imageUrl;
@property NSNumber *count;

-(NSURL*)imageNSURL;

-(NSInteger)quantityInCard;

-(void)image:(void(^)(UIImage *image))callback;


@end
