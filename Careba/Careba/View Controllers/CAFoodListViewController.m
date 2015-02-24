//
//  CAFoodListViewController.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/26/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "CAFoodListViewController.h"
#import "CAFoodCell.h"

@interface CAFoodListViewController() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation CAFoodListViewController

-(void)viewWillAppear:(BOOL)animated {
    [self applyWhiteStyle];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self applyBlackStyle];
}

-(void)checkout {
    
}

-(void)viewDidLoad {
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView registerNib:[UINib nibWithNibName:@"CAFoodCell" bundle:nil] forCellWithReuseIdentifier:@"CAFoodCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"CAFoodCellSingle" bundle:nil] forCellWithReuseIdentifier:@"CAFoodCellSingle"];
    
    if (self.vcMode == CAFoodListVCMultiMode) {
        
        
        UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navBarDish"] style:UIBarButtonItemStylePlain target:self action:@selector(checkout)];
        barButton.tintColor = [UIColor blackColor];
        self.navigationItem.rightBarButtonItem = barButton;
        
        /*
        UIButton *button = [[UIButton alloc] init];
        button.backgroundColor = [UIColor redColor];
        [button setImage:[UIImage imageNamed:@"navBarDish"] forState:UIControlStateNormal];
        
        BBBadgeBarButtonItem *barButton = [[BBBadgeBarButtonItem alloc] initWithCustomView:button];
        barButton.tintColor = [UIColor blackColor];
        
        barButton.badgeValue = @"1";
        
        
        self.navigationItem.rightBarButtonItem = barButton;*/
    }
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
 
    NSString *reuse = self.vcMode == CAFoodListVCMultiMode ? @"CAFoodCell" : @"CAFoodCellSingle";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuse forIndexPath:indexPath];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat sideSize = collectionView.frame.size.width/2;
    return CGSizeMake(sideSize, sideSize);
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

@end
