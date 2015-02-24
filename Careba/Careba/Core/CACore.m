//
//  CACore.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/30/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "CACore.h"
#import "CAPlacesManager.h"
#import "CAMenuManager.h"

@implementation CACore {
    CAPlacesManager *_manager;
    CAMenuManager *_menuManager;
}

+ (id)sharedInstance {
    static CACore *singletone = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletone = [[self alloc] init];
    });
    return singletone;
}

-(id)init {
    if (self = [super init]) {
        _manager = [[CAPlacesManager alloc] init];
        _menuManager = [CAMenuManager new];
    }
    return self;
}

-(void)places:(void (^)(NSError *error, NSArray *places))completion {
    [_manager places:completion];
}

-(void)menuForPlace:(CAPlace*)place withHandler:(void (^)(NSError *error, NSArray *menus))completion {
    [_menuManager menuForPlace:place withHandler:completion];
}




@end
