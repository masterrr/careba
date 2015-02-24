//
//  CASet.h
//  Careba
//
//  Created by Dmitry Kurilo on 2/15/15.
//  Copyright (c) 2015 Dmitry Kurilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CASection.h"

@interface CASet : MTLModel<MTLJSONSerializing>

@property NSNumber *id;
@property NSNumber *price;
@property NSString *name;
@property NSArray *sections;

-(NSString*)subname;

@end
