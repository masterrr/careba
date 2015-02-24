//
//  CACardViewController.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/27/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "CACardViewController.h"

@interface CACardViewController() <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)link:(id)sender;

@end

@implementation CACardViewController

-(void)viewWillAppear:(BOOL)animated {
    [self applyWhiteStyle];
    self.navigationController.navigationBar.translucent = YES;
}

-(void)viewWillDisappear:(BOOL)animated {
    [self applyBlackStyle];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewDidLoad {
    self.title = @"Привязать карту";
    
    UIView *headerView = _tableView.tableHeaderView;
    headerView.frame = CGRectMake(0, 0, headerView.frame.size.width, 80.0f);
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *dequeueIdentifier;
    
    switch (indexPath.row) {
        case 0:
            dequeueIdentifier = @"cardNumberCell";
            break;
        case 1:
            dequeueIdentifier = @"expiryCell";
            break;
        case 2:
            dequeueIdentifier = @"nameCell";
            break;
        case 3:
            dequeueIdentifier = @"CVCCell";
            break;
        default:
            break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dequeueIdentifier];
    return cell;
    
}



- (IBAction)link:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
