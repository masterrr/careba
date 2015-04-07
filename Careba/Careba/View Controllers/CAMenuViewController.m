//
//  CAMenuViewController.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/22/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "CAMenuViewController.h"
#import "CAMenuCell.h"

@interface CAMenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CAMenuViewController
- (IBAction)socialTap:(id)sender {
    NSLog(@"social tap");
}
- (IBAction)profileTap:(id)sender {
    [self switchToName:@"CAProfileViewController"];
}

-(void)viewDidLoad {
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CAMenuCell *menuCell = (CAMenuCell*)[tableView dequeueReusableCellWithIdentifier:@"menuCell"];
    
    NSString *labelText = @"";
    NSString *iconViewImageName = @"";
    NSString *counterText = @"";
    
    switch (indexPath.row) {
        case 0:
            labelText = @"Заказать еду";
            iconViewImageName = @"menuDish";
            break;
        case 1:
            labelText = @"История заказов";
            iconViewImageName = @"menuHistory";
            break;
        case 2:
            labelText = @"Баллы";
            counterText = @"123";
            iconViewImageName = @"menuCoins";
            break;
        case 3:
            labelText = @"О приложении";
            iconViewImageName = @"menuInfo";
            break;
        default:
            break;
    }
    
    //menuCell.iconView.backgroundColor = [UIColor redColor];
    menuCell.label.text = labelText;
    menuCell.iconView.image = [UIImage imageNamed:iconViewImageName];
    menuCell.counter.text = counterText;
    
    return menuCell;
}


-(id)instatiateWithName:(NSString*)objectName {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    id c = [mainStoryboard instantiateViewControllerWithIdentifier:objectName];
    return c;
}

-(void)switchToName:(NSString*)objectName {
    [[SlideNavigationController sharedInstance] popAllAndSwitchToViewController:[self instatiateWithName:objectName] withSlideOutAnimation:NO andCompletion:nil];
    
   // [[SlideNavigationController sharedInstance] popAllAndSwitchToViewController: withCompletion:nil];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            [self switchToName:@"CACafeListViewController"];
            break;
        case 1:
            [self switchToName:@"CAHistoryViewController"];
            break;
        case 2:
            [self switchToName:@"CAPointsViewController"];
            break;
        case 3:
            [self switchToName:@"CAAboutViewController"];
            break;
        default:
            break;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

@end
