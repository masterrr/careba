//
//  CACore.h
//  Careba
//
//  Created by Dmitry Kurilo on 12/30/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CAPlace.h"

@interface CACore : NSObject

+ (id)sharedInstance;

-(void)places:(void (^)(NSError *error, NSArray *places))completion;
-(void)menuForPlace:(CAPlace*)place withHandler:(void (^)(NSError *error, NSArray *menus))completion;

@end
