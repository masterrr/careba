//
//  CACheckoutViewController.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/25/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "CACheckoutViewController.h"

@implementation CACheckoutViewController

-(void)viewWillAppear:(BOOL)animated {
    [self applyWhiteStyle];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self applyBlackStyle];
}

-(void)checkout {
    [self performSegueWithIdentifier:@"checkoutToPhoneNumber" sender:self];
}

-(void)viewDidLoad {
    self.title = @"Итого 1 235 ₽";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Оплатить" style:UIBarButtonItemStylePlain target:self action:@selector(checkout)];
    
    self.navigationItem.rightBarButtonItem = item;
    
}

@end
