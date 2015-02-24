//
//  Constants.h
//  Careba
//
//  Created by Dmitry Kurilo on 12/10/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const kYandexMapKey;

FOUNDATION_EXPORT NSString *const kImageBaseUrl;

FOUNDATION_EXPORT NSString *const kBaseUrl;
FOUNDATION_EXPORT NSString *const kPathPlaces;
FOUNDATION_EXPORT NSString *const kPathMenus;

#define RGB(r, g, b) \
[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBA(r, g, b, a) \
[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@interface Constants : NSObject

+(NSString*)pathWithTarget:(NSString*)target;


+(NSString*)fullImageUrl:(NSString*)imageUrl;
+(NSDictionary*)countryCodes;
+(UIFont*)defaultFont;

@end
