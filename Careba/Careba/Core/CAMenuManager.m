//
//  CAMenuManager.m
//  Careba
//
//  Created by Dmitry Kurilo on 2/15/15.
//  Copyright (c) 2015 Dmitry Kurilo. All rights reserved.
//

#import "CAMenuManager.h"
#import "CAMenu.h"
#import <AFHTTPRequestOperationManager.h>
#define AFManager [AFHTTPRequestOperationManager manager]


@implementation CAMenuManager

-(void)menuForPlace:(CAPlace*)place withHandler:(void (^)(NSError *error, NSArray *menus))completion {
    [AFManager POST:[Constants pathWithTarget:kPathMenus] parameters:@{@"token":@"cd504844af235ae161dac430d92d682c", @"id":place.id}  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response=== %@", responseObject);
        NSArray *menus = [MTLJSONAdapter modelsOfClass:[CAMenu class] fromJSONArray:responseObject error:nil];
        
        completion(nil, menus);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

@end


