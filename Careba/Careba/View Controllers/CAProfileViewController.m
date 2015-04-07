//
//  CAProfileViewController.m
//  Careba
//
//  Created by Dmitry Kurilo on 3/12/15.
//  Copyright (c) 2015 Dmitry Kurilo. All rights reserved.
//

#import "CAProfileViewController.h"
#import "CAProfileCell.h"

@interface CAProfileViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CAProfileViewController


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
    
    self.title = @"Профиль";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CAProfileCell *cell = (CAProfileCell*)[tableView dequeueReusableCellWithIdentifier:@"CAProfileCell"];
    
    NSString *title = @"";
    NSString *subtitle = @"";
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                title = @"Имя, фамилия";
                subtitle = @"Ваше имя и фамилия";
                break;
            case 1:
                title = @"Телефон";
                subtitle = @"+375 29 234 42 43";
                break;
            case 2:
                title = @"Платежная карта";
                subtitle = @"Привязать";
            default:
                break;
        }
        
        cell.disclosureIndicator.hidden = indexPath.row != 2;
    }
    
    cell.mainLabel.text = title;
    cell.secondLabel.text = subtitle;
    
    if (indexPath.section == 1) {
        cell.mainLabel.textColor = RGB(255, 0, 0);
        cell.mainLabel.text = @"Выйти";
    }
    
    
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 3 : 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
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
