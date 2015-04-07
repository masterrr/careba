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
@property (weak, nonatomic) IBOutlet UILabel *aboutFirstLineLabel;
@property (weak, nonatomic) IBOutlet UILabel *aboutSecondLineLabel;


- (IBAction)checkout:(id)sender;

@end

@implementation CABusinessLunchViewController {
    id _selectedObject;
}

-(void)viewWillAppear:(BOOL)animated {
    [self applyWhiteStyle];
    self.navigationController.navigationBar.translucent = false;
}

-(void)viewWillDisappear:(BOOL)animated {
    [self applyBlackStyle];
    self.navigationController.navigationBar.translucent = true;

}

-(void)viewDidLoad {
    self.title = _set.name;
    
    _aboutFirstLineLabel.hidden = true;
    _aboutSecondLineLabel.text = [NSString stringWithFormat:@"Комплекс стоит %@ р.", _set.price];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    UIView *header = _tableView.tableHeaderView;
    header.frame = CGRectMake(0, 0, header.frame.size.width, 73.0f);
    NSLog(@"wwww/ %f", header.frame.size.width);
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CASection *section = _set.sections[indexPath.row];
    
    
    
    CABusinessLunchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CABusinessLunchCell"];
    

    cell.dishKindLabel.text = section.name;
    cell.dishNameLabel.text = @"";
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedObject = _set.sections[indexPath.row];
    [self performSegueWithIdentifier:@"businessLunchToFoodList" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"businessLunchToFoodList"]) {
        CAFoodListViewController *vc = (CAFoodListViewController*)[segue destinationViewController];
        vc.vcMode = CAFoodListVCSingleMode;
        vc.section = _selectedObject;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _set.sections.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (IBAction)checkout:(id)sender {
    [self performSegueWithIdentifier:@"businessLunchToCheckout" sender:self];
}
@end
