//
//  CAFoodListViewController.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/26/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "CAFoodListViewController.h"
#import "CAFoodCell.h"
#import "CAFoodCellSingle.h"
#import <M13BadgeView/M13BadgeView.h>

@interface CAFoodListViewController() <UICollectionViewDataSource, UICollectionViewDelegate, CAFoodCellDelegate> {
    M13BadgeView *_badgeView;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation CAFoodListViewController

-(void)viewWillAppear:(BOOL)animated {
    [self applyWhiteStyle];
    [self.collectionView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self applyBlackStyle];
}

-(void)checkout {
    
}

-(void)viewDidLoad {
    //_title = _section.name;
    
    self.title = _section.name;
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView registerNib:[UINib nibWithNibName:@"CAFoodCell" bundle:nil] forCellWithReuseIdentifier:@"CAFoodCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"CAFoodCellSingle" bundle:nil] forCellWithReuseIdentifier:@"CAFoodCellSingle"];
    
    if (self.vcMode == CAFoodListVCMultiMode) {
        UIButton *button = [[UIButton alloc] init];
        button.tintColor =  [UIColor blackColor];
        [button setImage:[UIImage imageNamed:@"navBarDish"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(orderFood:) forControlEvents:UIControlEventTouchUpInside];
        [button sizeToFit];

        _badgeView = [[M13BadgeView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [button addSubview:_badgeView];
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
        item.tintColor = [UIColor blackColor];
        self.navigationItem.rightBarButtonItem = item;
        
        [self updateBadgeValue];

    }
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    NSString *reuse = self.vcMode == CAFoodListVCMultiMode ? @"CAFoodCell" : @"CAFoodCellSingle";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuse forIndexPath:indexPath];
    
    if (self.vcMode == CAFoodListVCMultiMode) {
        CAFoodCell *foodCell = (CAFoodCell*)cell;
        foodCell.delegate = self;
        [foodCell setItem:_section.items[indexPath.row]];
    }
    
    if (self.vcMode == CAFoodListVCSingleMode) {
        CAFoodCellSingle *foodCellSingle = (CAFoodCellSingle*)cell;
        [foodCellSingle setItem:_section.items[indexPath.row]];
        
    }
    
    return cell;
}

- (IBAction)orderFood:(id)sender {
    [self performSegueWithIdentifier:@"foodListToCheckout" sender:self];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat sideSize = collectionView.frame.size.width/2;
    return CGSizeMake(sideSize, sideSize);
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _section.items.count;
}

-(void)updateBadgeValue {
    _badgeView.text = [NSString stringWithFormat:@"%lu", (long)[ShopCard countFoodItems]];

}

-(void)clickedUp:(CAItem *)item {
    [ShopCard addFoodItem:item];
    [self updateBadgeValue];
}

-(void)clickedDown:(CAItem *)item {
    [ShopCard removeFoodItem:item];
    [self updateBadgeValue];
}

@end
