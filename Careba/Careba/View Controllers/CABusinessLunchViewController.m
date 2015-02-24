//
//  CABusinessLunchViewController.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/25/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "CABusinessLunchViewController.h"
#import "CABusinessLunchCell.h"
#import "CAFoodListViewController.h"

@interface CABusinessLunchViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)checkout:(id)sender;

@end

@implementation CABusinessLunchViewController

-(void)viewWillAppear:(BOOL)animated {
    [self applyWhiteStyle];
    self.navigationController.navigationBar.translucent = false;
}

-(void)viewWillDisappear:(BOOL)animated {
    [self applyBlackStyle];
    self.navigationController.navigationBar.translucent = true;

}

-(void)viewDidLoad {
    self.title = @"Бизнес-ланч №1";
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    UIView *header = _tableView.tableHeaderView;
    header.frame = CGRectMake(0, 0, header.frame.size.width, 73.0f);
    NSLog(@"wwww/ %f", header.frame.size.width);
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CABusinessLunchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CABusinessLunchCell"];
    
    NSString *dishName = @"", *dishKind = @"";
    
    switch (indexPath.row) {
        case 0:
            dishKind = @"Салат";
            dishName = @"Греческий";
            break;
        case 1:
            dishKind = @"Суп";
            dishName = @"Борщ";
            break;
        case 2:
            dishKind = @"Горячее блюдо";
            break;
        case 3:
            dishKind = @"Напиток";
            dishName = @"Coca-Cola";
        default:
            break;
    }
    
    cell.dishKindLabel.text = dishKind;
    cell.dishNameLabel.text = dishName;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"businessLunchToFoodList" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"businessLunchToFoodList"]) {
        CAFoodListViewController *vc = (CAFoodListViewController*)[segue destinationViewController];
        vc.vcMode = CAFoodListVCSingleMode;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (IBAction)checkout:(id)sender {
    [self performSegueWithIdentifier:@"businessLunchToCheckout" sender:self];
}
@end
