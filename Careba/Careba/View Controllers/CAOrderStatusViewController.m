//
//  CAOrderStatusViewController.m
//  Careba
//
//  Created by Dmitry Kurilo on 3/13/15.
//  Copyright (c) 2015 Dmitry Kurilo. All rights reserved.
//

#import "CAOrderStatusViewController.h"
#import "CAOrderStatusCell.h"
#import "CAShopCard.h"
#import "UIImage+Color.h"

@interface CAOrderStatusViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)clos:(id)sender;

@end

@implementation CAOrderStatusViewController


-(void)viewWillAppear:(BOOL)animated {
    [self applyWhiteStyle];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self applyBlackStyle];
}

- (void)viewDidLoad {
    self.title = @"Оплачено";
    [super viewDidLoad];
    
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    
    
    UIView *header = _tableView.tableHeaderView;
    header.frame = CGRectMake(header.frame.origin.x, header.frame.origin.y, header.frame.size.width, 95.0f);
    
    UIView *footer = _tableView.tableFooterView;
    footer.frame = CGRectMake(footer.frame.origin.x, footer.frame.origin.y, footer.frame.size.width, 80.0f);
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CAOrderStatusCell *cell = (CAOrderStatusCell*)[tableView dequeueReusableCellWithIdentifier:@"CAOrderStatusCell"];
    CAItem *item = (CAItem*)[ShopCard foodItems].allKeys[indexPath.row];
    
    __weak CAOrderStatusCell *weakCell = cell;
    
    NSInteger quantity = ((NSNumber*)[ShopCard foodItems].allValues[indexPath.row]).integerValue;
    
    [cell.imgView setImageWithURLRequest:[NSURLRequest requestWithURL:[item imageNSURL]]
                        placeholderImage:[UIImage imageWithColor:self.view.backgroundColor andSize:CGSizeMake(25, 25)]
                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                     weakCell.imgView.image = image;
                                     [weakCell setNeedsLayout];
                                 } failure:nil];
    
    cell.foodNameLabel.text = item.name;
    cell.priceLabel.text = item.priceText;
    cell.quantityLabel.text = [NSString stringWithFormat:@"×%d", quantity];
    
    cell.imgView.layer.cornerRadius = 25.0f;
    cell.imgView.clipsToBounds = YES;
    cell.imgView.contentMode = UIViewContentModeScaleAspectFill;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [ShopCard foodItems].count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clos:(id)sender {
    
    if ([self.checkoutNextVC respondsToSelector:@selector(popToRoot)]) {
        [self.checkoutNextVC popToRoot];
    }
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}
@end
