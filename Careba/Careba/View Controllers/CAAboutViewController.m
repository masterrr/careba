//
//  CAAboutViewController.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/23/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "CAAboutViewController.h"
#import "UIView+Utils.h"
#import "CAAboutSocialCell.h"
#import "CATextCell.h"

@interface CAAboutViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CAAboutViewController

-(BOOL)slideNavigationControllerShouldDisplayLeftMenu {
    return YES;
}

-(void)viewDidAppear:(BOOL)animated {
    [self applyWhiteStyle];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self applyBlackStyle];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) { return 1; }
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    
    if (indexPath.section == 0) {
        CAAboutSocialCell *cell1 = (CAAboutSocialCell*)[tableView dequeueReusableCellWithIdentifier:@"CAAboutSocialCell"];
        
        NSString *title;
        NSString *imageName;
        
        switch (indexPath.row) {
            case 0:
                title = @"Группа в Фейсбуке";
                imageName = @"aboutFb";
                break;
            case 1:
                title = @"Группа во Вконтакте";
                imageName = @"aboutVk";            break;
            case 2:
                title = @"Твиттер";
                imageName = @"aboutTwitter";
            default:
                break;
        }
        
        cell1.label.text = title;
        cell1.iconView.image = [UIImage imageNamed:imageName];
        return cell1;
    }
    
    if (indexPath.section == 1) {
        CATextCell *cell2 = [self.tableView dequeueReusableCellWithIdentifier:@"CATextCell"];
        
        NSString *title;
        
        switch (indexPath.row) {
            case 0:
                title = @"Оцените приложение";
                break;
            case 1:
                title = @"Напишите нам";
                break;
            default:
                title = @"Расскажите друзьям";
                break;
        }
        
        
        cell2.label.text = title;
        return cell2;
    }
    
    if (indexPath.section == 2) {
        CATextCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"CATextCell"];
        cell3.label.text = @"Пользовательское соглашение";
        return cell3;
    }
    
    return cell;
}

-(void)viewDidLoad {
    self.title = @"О приложении";
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UIView* header = _tableView.tableHeaderView;
    header.frame = CGRectMake(0, 0, header.frame.size.width, 90.0f);
    
    UIView *footer = _tableView.tableFooterView;
    footer.frame = CGRectMake(0, 0, footer.frame.size.width, 30.0f);    
}


@end
