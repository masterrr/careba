//
//  CACafeListViewController.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/10/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "CACafeListViewController.h"
#import "UIViewController+CAFakeNavBar.h"
#import "CAFoodKindCollectionViewCell.h"
#import "CACafeCell.h"
#import "CAPlace.h"
#import "UIImageView+AFNetworking.h"
#import "CACafeAboutViewController.h"

@interface CACafeListViewController ()

@property (weak, nonatomic) IBOutlet YMKMapView *mapView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeight;
@property (weak, nonatomic) IBOutlet UITextField *cafeSearchTextField;

@end



@implementation CACafeListViewController {
    CGFloat defaultTableViewHeightConstant, maximumTableViewHeightConstant;
    BOOL draggingTableViewNow;
    CGFloat mapCoordinateAsDraggingStarted;
    
    NSArray *_places;
    CAPlace *_selectedPlace;
}

-(BOOL)slideNavigationControllerShouldDisplayLeftMenu {
    return YES;
}


- (void)viewDidLoad {
    [CACore sharedInstance];
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self configureMapView];
    [self setNavBarTitle:@(798)];
    [self setupTableView];

    [self setupNavBarButtons];
    [self setupCollectionView];
    
    [self applyFakeNavBarToView:_mapView];
    
    draggingTableViewNow = NO;
    
    [[CACore sharedInstance] places:^(NSError *error, NSArray *places) {
        [self.tableView beginUpdates];
        _places = places;
        [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
        [self.tableView reloadData];
    }];
}

-(void)viewWillAppear:(BOOL)animated {
}

-(void)viewWillLayoutSubviews {

}
-(void)viewDidAppear:(BOOL)animated
{
    maximumTableViewHeightConstant = self.view.frame.size.height;
    maximumTableViewHeightConstant -= self.navigationController.navigationBar.frame.size.height;
    maximumTableViewHeightConstant -= _collectionViewHeight.constant;
    maximumTableViewHeightConstant -= [[UIApplication sharedApplication] statusBarFrame].size.height;
    
    defaultTableViewHeightConstant = _tableViewHeight.constant;
}

-(void)setupCollectionView
{
    _collectionView.backgroundColor = [UIColor clearColor];
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    
    UIVisualEffectView *visualEffectView;
    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    visualEffectView.frame = _collectionView.bounds;
    
    _collectionView.backgroundView = visualEffectView;
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CAFoodKindCollectionViewCell *foodKindCell = (CAFoodKindCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"kindCollectionCell" forIndexPath:indexPath];
    
    NSString *imageName;
    NSString *title;
    
    switch (indexPath.row) {
        case 0:
            title = @"Завтрак";
            imageName = @"breakfastDonut";
            break;
        case 1:
            title = @"Обед";
            imageName = @"lunchSoup";
            break;
        case 2:
            title = @"Кофейни";
            imageName = @"coffeeCoffee";
            break;
        case 3:
            title = @"Италия и Европа";
            imageName = @"euroPasta";
            break;
        case 4:
            title = @"Америка и Мексика";
            imageName = @"americanBurger";
            break;
        default:
            break;
    }
    
    foodKindCell.title.text = title;
    foodKindCell.foodImage.image = [UIImage imageNamed:imageName];
    
    return foodKindCell;
}

-(void)setupTableView
{
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     CAPlace *place = (CAPlace*)_places[indexPath.row];
    return ![place IsPromotion] && ![place IsFoodForPoints] ? 110 : 140;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _places.count ?: 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CACafeCell *cell = (CACafeCell*)[tableView dequeueReusableCellWithIdentifier:@"CACafeCell"];
    
        CAPlace *place = (CAPlace*)_places[indexPath.row];
        NSLog(@"logo %@", place.logoUrl);
        
        cell.nameLabel.text = place.name;
        cell.addressLabel.text = place.address;
        NSURL *logoUrl = [NSURL URLWithString:[Constants fullImageUrl:place.logoUrl]];
        
        [cell.logoImageView setImageWithURL:logoUrl placeholderImage:[UIImage new]];
        
        if (![place IsPromotion]) {
            [cell.promotionTag removeFromSuperview];
        }
        
        if (![place IsFoodForPoints]) {
            [cell.pointsTag removeFromSuperview];
        }
        
        if ([place.avgSum length] > 0) {
            cell.avgSumLabel.text = [NSString stringWithFormat:@"сред. чек — %@ ₽", place.avgSum];
        } else {
            [cell.avgSumLabel removeFromSuperview];
            [cell.avgSumIcon removeFromSuperview];
        }
        
        if ([place.rating length] > 0) {
            cell.ratingLabel.text = place.rating;
        } else {
            [cell.ratingLabel removeFromSuperview];
        };
        
        if (!place.wifi) {
            [cell.wifiIcon removeFromSuperview];
        }
        
        if (!place.parking) {
            [cell.parkingIcon removeFromSuperview];
        }
    

    NSDateFormatter *formatterOut = [[NSDateFormatter alloc] init];
    formatterOut.dateFormat = @"HH:mm";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    
    NSDate *date;
    NSError *error;
    [formatter getObjectValue:&date forString:place.dateClose range:nil error:&error];
    cell.closeTimeLabel.text = [NSString stringWithFormat:@"до %@", [formatterOut stringFromDate:date]];
    
    
    [cell setNeedsLayout];
    [cell setNeedsDisplay];


    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedPlace = (CAPlace*)_places[indexPath.row];
    [self performSegueWithIdentifier:@"fromCafeToCafeAbout" sender:self];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    draggingTableViewNow = YES;
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    draggingTableViewNow = NO;
    
    CGFloat win = (defaultTableViewHeightConstant+maximumTableViewHeightConstant)/2;
    _tableViewHeight.constant = _tableViewHeight.constant > win ?maximumTableViewHeightConstant : defaultTableViewHeightConstant;
    
    [UIView animateWithDuration:0.3f animations:^{
        [self.view layoutIfNeeded];
    }];
}


-(void)mapView:(YMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    mapCoordinateAsDraggingStarted = mapView.centerMapPoint.y;
}

- (void)mapViewWasDragged:(YMKMapView *)mapView {
    
    [self.cafeSearchTextField resignFirstResponder];
    
    /*CGFloat offset = (mapCoordinateAsDraggingStarted-mapView.centerMapPoint.y)/128.0f;
    
    mapCoordinateAsDraggingStarted = mapView.centerMapPoint.y;
    
    _tableViewHeight.constant -= offset;
    
    [UIView animateWithDuration:0.05f animations:^{
        [self.view layoutIfNeeded];
    }];*/
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.cafeSearchTextField resignFirstResponder];
    
    //if (!draggingTableViewNow) { return; }
   /* CGFloat offset = scrollView.contentOffset.y;
    
    CGFloat currentHeight = _tableViewHeight.constant;
    
    if (currentHeight+offset <= defaultTableViewHeightConstant) { return; }
    if (currentHeight+offset >= maximumTableViewHeightConstant) { return; }
    
    CGFloat path = maximumTableViewHeightConstant-defaultTableViewHeightConstant;
    CGFloat passed = maximumTableViewHeightConstant-currentHeight;
        
    _tableViewHeight.constant += offset;
    [self.view layoutIfNeeded];
    
    [scrollView setContentOffset:CGPointMake(0, 0)];*/
}

-(void)setupNavBarButtons
{
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"NavBarMenu"] style:UIBarButtonItemStylePlain target:self action:nil];
    leftBarButton.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"NavBarMap"] style:UIBarButtonItemStylePlain target:self action:nil];
    rightBarButton.tintColor = [UIColor whiteColor];
    
    //[self.navigationItem setLeftBarButtonItem:leftBarButton];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
}

-(void)setNavBarTitle:(NSNumber*)numberOfPlacesAvailable
{
    NSString *title = [NSString stringWithFormat:@"%@ мест в Москве", numberOfPlacesAvailable];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:nil action:nil];
    self.title = title;
    [self.navigationController setTitle:title];
    [self.navigationItem setTitle:title];
    
}

-(void)configureMapView {
    _mapView.showsUserLocation = YES;
    _mapView.showTraffic = NO;
    _mapView.delegate = self;
    [self.mapView setCenterCoordinate:YMKMapCoordinateMake(55.733945, 37.588102) atZoomLevel:16 animated:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CACafeAboutViewController *vc = (CACafeAboutViewController*)segue.destinationViewController;
    vc.place = _selectedPlace;
}

@end
