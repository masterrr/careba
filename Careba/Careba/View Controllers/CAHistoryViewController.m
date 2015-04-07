//
//  CAHistoryViewController.m
//  Careba
//
//  Created by Dmitry Kurilo on 3/7/15.
//  Copyright (c) 2015 Dmitry Kurilo. All rights reserved.
//

#import "CAHistoryViewController.h"
#import "CAHistoryCell.h"

@interface CAHistoryViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *noOrdersLabel;
@property (weak, nonatomic) IBOutlet UIImageView *noOrdersImageView;

@end

@implementation CAHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"История заказов";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    // Do any additional setup after loading the view.
}


-(BOOL)slideNavigationControllerShouldDisplayLeftMenu {
    return YES;
}

-(void)viewWillAppear:(BOOL)animated {
    
    _tableView.hidden = YES;
    
    [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(show) userInfo:nil repeats:NO];
    [self applyWhiteStyle];
}

-(void)show {
    _tableView.hidden = NO;
    _noOrdersImageView.hidden = _noOrdersLabel.hidden = YES;
}

-(void)viewDidAppear:(BOOL)animated {
    [self applyWhiteStyle];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self applyBlackStyle];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CAHistoryCell *cell = (CAHistoryCell*)[tableView dequeueReusableCellWithIdentifier:@"CAHistoryCell"];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 67.0f;
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
