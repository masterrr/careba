//
//  CAPlace.h
//  Careba
//
//  Created by Dmitry Kurilo on 12/30/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface CAPlace : MTLModel <MTLJSONSerializing>

@property NSNumber *id;
@property NSString *name;
@property NSString *address;
@property NSString *phone;
@property NSString *about;
@property NSString *metro;
@property BOOL isOrderEnabled;
@property NSString *logoUrl;
@property NSString *bgUrl;
@property NSArray *bgUrls;
@property NSString *dateClose;
@property NSDate *dateOpen;
@property NSString *tags;
@property NSString *avgSum;
@property NSString *rating;
@property BOOL wifi;
@property BOOL parking;

-(BOOL)IsFoodForPoints;
-(BOOL)IsPromotion;

-(NSURL*)logoNSURL;
-(NSURL*)bgNSURL;

@end
