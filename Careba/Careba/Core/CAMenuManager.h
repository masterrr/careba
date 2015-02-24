//
//  CAMenuManager.h
//  Careba
//
//  Created by Dmitry Kurilo on 2/15/15.
//  Copyright (c) 2015 Dmitry Kurilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CAPlace.h"

@interface CAMenuManager : NSObject

-(void)menuForPlace:(CAPlace*)place withHandler:(void (^)(NSError *error, NSArray *menus))completion;

@end
