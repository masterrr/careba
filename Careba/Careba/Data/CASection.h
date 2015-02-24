//
//  CASection.h
//  Careba
//
//  Created by Dmitry Kurilo on 2/15/15.
//  Copyright (c) 2015 Dmitry Kurilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

//"section_id": "43",
//"section_name": "Блюда на большую компанию",

@interface CASection : MTLModel<MTLJSONSerializing>

@property NSNumber *id;
@property NSString *name;
@property NSArray *items;

@end
