//
//  CACheckoutNextViewController.m
//  Careba
//
//  Created by Dmitry Kurilo on 3/3/15.
//  Copyright (c) 2015 Dmitry Kurilo. All rights reserved.
//

#import "CACheckoutNextViewController.h"
#import "CACheckoutNextCell.h"
#import "CADatePickerCell.h"
#import "CAOrderStatusViewController.h"

@interface CACheckoutNextViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)pay:(id)sender;


@end

@implementation CACheckoutNextViewController {
    NSInteger _firstIndex;
    NSInteger _secondIndex;
    NSString *dateString;
    NSDate *_date;
}

-(void)viewWillAppear:(BOOL)animated {
    self.title = [NSString stringWithFormat:@"Итого %d ₽", [ShopCard grandTotal]];
    
    [self applyWhiteStyle];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self applyBlackStyle];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    _firstIndex = _secondIndex = -1;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
}

-(BOOL)isDateInTomorrow:(NSDate*)date {
    NSCalendar *cal = [NSCalendar calendarWithIdentifier: NSCalendarIdentifierGregorian];
    return [cal isDateInTomorrow:date];
}

-(BOOL)isDateToday:(NSDate*)date {
    NSCalendar *cal = [NSCalendar calendarWithIdentifier: NSCalendarIdentifierGregorian];
    return [cal isDateInToday:date];
}

-(void)datePicked:(UIDatePicker*)picker {
    NSDate *d = [picker date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"HH:mm"];
    NSString *timeString = [formatter stringFromDate:d];
    
    
    if ([self isDateInTomorrow:d] || [self isDateToday:d]) {
        dateString = [NSString stringWithFormat:@"%@, %@", [self isDateInTomorrow:d] ? @"Завтра": @"Сегодня", timeString];
    } else {
        NSDateFormatter *f = [NSDateFormatter new];
        [f setDateStyle:NSDateFormatterShortStyle];
        [f setTimeStyle:NSDateFormatterShortStyle];
        dateString = [f stringFromDate:d];
    }
    
    _date = d;
    
    NSInteger minutes = [d timeIntervalSinceNow]/60.0f;
    
    [ShopCard setMinutes:minutes];
    [self.tableView reloadData];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 3) {
        CADatePickerCell *cell = (CADatePickerCell*)[tableView dequeueReusableCellWithIdentifier:@"CADatePickerCell"];
        cell.picker.minimumDate = [[NSDate date] dateByAddingTimeInterval:60*30];
        cell.picker.minuteInterval = 10;
        cell.picker.maximumDate = [[NSDate date] dateByAddingTimeInterval:60*60*240];
        [cell.picker addTarget:self action:@selector(datePicked:) forControlEvents:UIControlEventValueChanged];

        return cell;
    }
    
    CACheckoutNextCell *cell = (CACheckoutNextCell*)[tableView dequeueReusableCellWithIdentifier:@"CACheckoutNextCell"];
    

    
    if (indexPath.section == 0) {
        [cell setTickHidden:indexPath.row != _firstIndex];
    } else if (indexPath.section == 1) {
        [cell setTickHidden:indexPath.row != _secondIndex];
    }
    
    NSString *title = @"";
    NSString *sub = @"";
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    title = @"Упакуйте с собой";
                    break;
                case 1:
                    title = @"Ем на месте";
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    title = @"Приду в ближайшее время";
                    break;
                case 1:
                    title = @"Через 30 минут";
                    break;
                case 2:
                    title = @"Другое время";
                    sub = dateString;
                    break;
                default:
                    break;
            }
        default:
            break;
    }
    
    cell.mainLabel.text = title;
    cell.secondLabel.text = sub;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) { return; }
    
    if (indexPath.section == 0) {
        _firstIndex = indexPath.row;
        [ShopCard setPickupKind:_firstIndex == 0 ? CAShopPickupKindPack : CAShopPickupKindEatingAtThePlace];
        
    } else if (indexPath.section == 1) {
        _secondIndex = indexPath.row;
        [ShopCard setPickupTimeMode:_secondIndex == 0 ? CAShopPickupTimeModeASAP : CAShopPickupTimeModeSpecifyMinutes];
        if (_secondIndex == 1) {
            [ShopCard setMinutes:30];
        }
        
        if (_secondIndex != 2) {
            dateString = @"";
        }
    }
    [_tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: return 2;
        case 1: return _secondIndex == 2 ? 4 : 3;
    }
    return -1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 3 ? 180 : 44;
}


- (IBAction)pay:(id)sender {
    [self performSegueWithIdentifier:@"checkoutNextToOrderStatus" sender:self];
}

-(void)popToRoot {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    CAOrderStatusViewController *dest = (CAOrderStatusViewController*)((UINavigationController*)segue.destinationViewController).topViewController;
    
    dest.checkoutNextVC = self;
    
}

@end
