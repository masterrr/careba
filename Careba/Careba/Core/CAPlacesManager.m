//
//  CAPlacesManager.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/30/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "CAPlacesManager.h"
#import "CAPlace.h"
#import <AFHTTPRequestOperationManager.h>
#define AFManager [AFHTTPRequestOperationManager manager]

@implementation CAPlacesManager {
    NSArray *_places;
}

-(void)places:(void (^)(NSError *error, NSArray *places))completion {
    [AFManager POST:[Constants pathWithTarget:kPathPlaces] parameters:@{@"token":@"cd504844af235ae161dac430d92d682c"}  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response=== %@", responseObject);
        _places = [MTLJSONAdapter modelsOfClass:[CAPlace class] fromJSONArray:responseObject error:nil];
        
        completion(nil, _places);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


@end
