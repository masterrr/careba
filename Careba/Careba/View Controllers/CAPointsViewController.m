//
//  CAPointsViewController.m
//  Careba
//
//  Created by Dmitry Kurilo on 3/7/15.
//  Copyright (c) 2015 Dmitry Kurilo. All rights reserved.
//

#import "CAPointsViewController.h"

@interface CAPointsViewController ()

@end

@implementation CAPointsViewController

-(BOOL)slideNavigationControllerShouldDisplayLeftMenu {
    return YES;
}

-(void)viewDidAppear:(BOOL)animated {
    [self applyWhiteStyle];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self applyBlackStyle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Баллы";
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
