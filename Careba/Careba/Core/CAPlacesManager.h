//
//  CAPlacesManager.h
//  Careba
//
//  Created by Dmitry Kurilo on 12/30/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CAPlacesManager : NSObject

-(void)places:(void (^)(NSError *error, NSArray *places))completion;

@end
