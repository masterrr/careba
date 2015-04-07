//
//  CACafeAboutViewController.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/17/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "CACafeAboutViewController.h"
#import "UIViewController+CAFakeNavBar.h"
#import "CAPlaceKindCollectionViewCell.h"
#import "CABusinessLunchViewController.h"
#import "CAFoodCell.h"
#import "UIView+Utils.h"
#import "CAFoodListViewController.h"
#import "UIImageView+AFNetworking.h"
#import "CAMenu.h"
#import "CASection.h"
#import "CAItem.h"
#import "CASet.h"
#import "CAFoodSectionCell.h"
#import "CAFoodSetCell.h"
#import <M13BadgeView/M13BadgeView.h>

typedef NS_ENUM(NSUInteger, kCafeTableMode) {
    kCafeTableModeBar,
    kCafeTableModePopular,
    kCafeTableModeBusinessLunch,
    kCafeTableModeMenu
};
@interface CACafeAboutViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, UIAlertViewDelegate> {
    NSArray *_menus;
    CAMenu *_currentSelectedMenu;
    id _selectedObject;
    M13BadgeView *_badgeView;
}

@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (weak, nonatomic) IBOutlet UITextField *ratingLabel;

@property (weak, nonatomic) IBOutlet UIView *parkingView;
@property (weak, nonatomic) IBOutlet UIView *wifiView;
@property (weak, nonatomic) IBOutlet UIView *openTillView;
@property (weak, nonatomic) IBOutlet UIView *avgSumView;

@property (weak, nonatomic) IBOutlet UILabel *averageSum;
@property (weak, nonatomic) IBOutlet UILabel *openTill;
@property (weak, nonatomic) IBOutlet UILabel *placeAddress;
@property (weak, nonatomic) IBOutlet UILabel *placeTitle;
@property (weak, nonatomic) IBOutlet UIImageView *placeAvatar;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *foodCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *featureSectionWidthLayoutConstraint;
@end

@implementation CACafeAboutViewController


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (collectionView == _collectionView) {
        return 1;
    } else if (collectionView == _foodCollectionView) {
        return 1;
    }
    return 0;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == _collectionView) {
        return _menus.count;
    } else if (collectionView == _foodCollectionView) {
        return 4;
    }
    return 0;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == _collectionView) {
        CAPlaceKindCollectionViewCell *cell = (CAPlaceKindCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"CAFoodKindCollectionViewCell" forIndexPath:indexPath];
        
        CAMenu *menu = _menus[indexPath.row];
        [cell setSelected:NO];
        [cell setTitle:menu.name];
        return cell;
    }
    
    if (collectionView == _foodCollectionView) {
        CAFoodCell *foodCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CAFoodCell" forIndexPath:indexPath];
        return foodCell;
    }
    
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (collectionView == _collectionView) {
        _currentSelectedMenu = _menus[indexPath.row];
        NSLog(@"selected %@", _currentSelectedMenu);
        [self.tableView reloadData];
    }
    
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (collectionView == _collectionView) {
        
        BOOL isSelected = NO;
        
        NSString *title = ((CAMenu*)_menus[indexPath.row]).name;
        
        CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:[CAPlaceKindCollectionViewCell usedFontForSelectedState:isSelected]}];
        return CGSizeMake(size.width+30, 45);
    } else if (collectionView == _foodCollectionView) {
        CGFloat sideSize = collectionView.frame.size.width/2;
        return CGSizeMake(sideSize, sideSize);
    }
    return CGSizeZero;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    if (_currentSelectedMenu.sets.count > 0) {
        CAFoodSetCell *fsc;
        fsc = [tableView dequeueReusableCellWithIdentifier:@"CAFoodSetCell"];
        CASet *set = _currentSelectedMenu.sets[indexPath.row];
        fsc.name.text = set.name;
        fsc.subName.text = set.subname;
        cell = fsc;
    } else if (_currentSelectedMenu.sections.count > 0) {
        CAFoodSectionCell *fsc;
        fsc = [tableView dequeueReusableCellWithIdentifier:@"CAFoodSectionCell"];
        CASection *section = _currentSelectedMenu.sections[indexPath.row];
        fsc.name.text = section.name;
        cell = fsc;
    }
    
   
    return cell;
}

-(BOOL)isSetSelected {
    return _currentSelectedMenu.sets.count > 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isSetSelected]) {
        _selectedObject = _currentSelectedMenu.sets[indexPath.row];
        [self performSegueWithIdentifier:@"cafeAboutToBusinessLunch" sender:self];
    } else {
        _selectedObject = _currentSelectedMenu.sections[indexPath.row];
        [self performSegueWithIdentifier:@"cafeAboutToFoodList" sender:self];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_currentSelectedMenu.sets.count > 0) {
        return _currentSelectedMenu.sets.count;
    } else if (_currentSelectedMenu.sections.count > 0) {
        return _currentSelectedMenu.sections.count;
    }
    return 0;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"cafeAboutToFoodList"]) {
        CAFoodListViewController *vc = (CAFoodListViewController*)[segue destinationViewController];
        vc.vcMode = CAFoodListVCMultiMode;
        if (![self isSetSelected]) {
            vc.section = _selectedObject;
        }
    } else if ([[segue identifier] isEqualToString:@"cafeAboutToBusinessLunch"]) {
        CABusinessLunchViewController *vc = (CABusinessLunchViewController*)[segue destinationViewController];
        if ([self isSetSelected]) {
            [vc setSet:_selectedObject];
        }
    }
    NSLog(@"i=i, %@", [segue identifier]);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self applyFakeNavBarToView:self.backgroundView];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;

    
    _foodCollectionView.delegate = self;
    _foodCollectionView.dataSource = self;
    [_foodCollectionView registerNib:[UINib nibWithNibName:@"CAFoodCell" bundle:nil] forCellWithReuseIdentifier:@"CAFoodCell"];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
        
    _featureSectionWidthLayoutConstraint.constant = self.view.frame.size.width/4;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_button"] style:UIBarButtonItemStylePlain target:self action:@selector(popBack:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    
    UIButton *button = [[UIButton alloc] init];
    button.tintColor =  [UIColor blackColor];
    [button setImage:[UIImage imageNamed:@"dish"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(orderFood:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
    _badgeView = [[M13BadgeView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [button addSubview:_badgeView];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    item.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item;
    
    [self updateBadgeValue];

    self.navigationController.interactivePopGestureRecognizer.enabled = true;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    [self setupPlace];
    [self setupMenu];
}

-(void)updateBadgeValue {
    _badgeView.text = [NSString stringWithFormat:@"%lu", (long)[ShopCard countFoodItems]];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [self updateBadgeValue];
    [super viewWillAppear:animated];
}

-(void)setupMenu {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[CACore sharedInstance] menuForPlace:_place withHandler:^(NSError *error, NSArray *menus) {
        _menus = menus;
        [self.collectionView reloadData];
        [self.tableView reloadData];
        if (_menus.count > 0) {
            [_collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
            [self collectionView:self.collectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];

        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}


-(void)setupPlace {
    [_placeAvatar setImageWithURL:_place.logoNSURL];
    _placeTitle.text = _place.name;
    _placeAddress.text = _place.address;
    [_backgroundView setImageWithURL:_place.bgNSURL];
    if (!_place.wifi) {
        [_wifiView removeFromSuperview];
    }
    if (!_place.parking) {
        _parkingView.hidden = YES;
    //    [_parkingView performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:NO];
        [self.view setNeedsLayout];
    }
    
    _ratingLabel.text = @" — ";
    _commentsLabel.text = @"0";
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssz"];
    NSDate *date  = [dateFormatter dateFromString:_place.dateClose];
    
    [dateFormatter setDateFormat:@"hh:mm"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    _openTill.text = dateString;
    
    if (_place.avgSum != nil) {
        _averageSum.text = _place.avgSum;
    } else {
        _avgSumView.hidden = YES;
     //   [_avgSumView performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:NO];
        [self.view setNeedsLayout];
    }
    
    [self.view layoutIfNeeded];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [ShopCard removeAllItems];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)popBack:(id)sender {
    if ([ShopCard countFoodItems] <= 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"Корзина не пуста" message:@"Очистить корзину и выбрать другое место?" delegate:self cancelButtonTitle:@"Отмена" otherButtonTitles:@"Да", nil];
        [v show];
    }
    
}

- (IBAction)orderFood:(id)sender {
    [self performSegueWithIdentifier:@"cafeAboutToCheckout" sender:self];
}
@end
