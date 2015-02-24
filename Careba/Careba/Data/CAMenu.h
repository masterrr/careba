//
//  CAMenu.h
//  Careba
//
//  Created by Dmitry Kurilo on 2/15/15.
//  Copyright (c) 2015 Dmitry Kurilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

//"menu_id": "38",
//"menu_active": true,
//"menu_name": "Основное меню",
//"hours_work_places": "11:00 - 23:30",

@interface CAMenu : MTLModel<MTLJSONSerializing>

@property NSNumber *id;
@property BOOL active;
@property NSString *name;
@property NSString *hours;
@property NSArray *sections;
@property NSArray *sets;

@end
