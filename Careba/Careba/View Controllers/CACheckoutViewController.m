//
//  CACheckoutViewController.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/25/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "CACheckoutViewController.h"
#import "CAItemCell.h"
#import "UIImage+Color.h"
#import "UIImageView+AFNetworking.h"
#import "CAPickerCell.h"

@interface CACheckoutViewController() <UITableViewDataSource, UITableViewDelegate, CAPickerCellProtocol, SlideNavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CACheckoutViewController {
    NSInteger _currentActiveRow;
}

-(void)viewWillAppear:(BOOL)animated {
    [self applyWhiteStyle];
    [[SlideNavigationController sharedInstance] setEnableSwipeGesture:NO];
}

-(void)viewWillDisappear:(BOOL)animated {
    [[SlideNavigationController sharedInstance] setEnableSwipeGesture:YES];
    [self applyBlackStyle];
}

-(void)checkout {
    [self performSegueWithIdentifier:@"checkoutToCheckoutNext" sender:self];
   // [self performSegueWithIdentifier:@"checkoutToPhoneNumber" sender:self];
}

-(void)updateGrandtotal {
    self.title = [NSString stringWithFormat:@"Итого %d ₽", [ShopCard grandTotal]];
}

-(void)viewDidLoad {
    [self updateGrandtotal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Оплатить" style:UIBarButtonItemStylePlain target:self action:@selector(checkout)];
    
    self.navigationItem.rightBarButtonItem = item;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 100.0f;
    
    UIView *f = _tableView.tableFooterView;
    
    _tableView.tableFooterView.frame = CGRectMake(f.frame.origin.x, f.frame.origin.y, f.frame.size.width, 60.0f);
    self.tableView.contentInset = UIEdgeInsetsMake(20.0f, 0, 0, 0);
    self.tableView.backgroundColor = [UIColor clearColor];
    
    _currentActiveRow = -1;
    
   // self.view.backgroundColor = [UIColor yellowColor];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        return 68.0f;
    } else {
        return _currentActiveRow == indexPath.row-1 ? 163.0f : 0.0f;
    }
    return 0.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [ShopCard foodItems].count*2;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __block BOOL shouldHide = NO;
    
    
    CAPickerCell *cell = (CAPickerCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section]];
    
    [CATransaction begin];
    
    [CATransaction setCompletionBlock:^{
        cell.pickerView.hidden = shouldHide;
    }];
    
    [self.tableView beginUpdates];

    if (_currentActiveRow == indexPath.row) {
        _currentActiveRow = -1;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        shouldHide = YES;
    } else {
        _currentActiveRow = indexPath.row;
        cell.pickerView.hidden = NO;
    }
    [self.tableView endUpdates];
    
    [CATransaction commit];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        CAItem *item = (CAItem*)[ShopCard foodItems].allKeys[indexPath.row/2];
        [ShopCard completelyRemoveFoodItem:item];
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath, [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView endUpdates];
        [self updateGrandtotal];
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *outCell;
    
    if (indexPath.row % 2 == 0) {
        
        CAItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CAItemCell"];
        CAItem *item = (CAItem*)[ShopCard foodItems].allKeys[indexPath.row/2];
        
        NSInteger quantity = ((NSNumber*)[ShopCard foodItems].allValues[indexPath.row/2]).integerValue;
        
        __weak CAItemCell *weakCell = cell;
        
        [cell.imgView setImageWithURLRequest:[NSURLRequest requestWithURL:[item imageNSURL]]
                            placeholderImage:[UIImage imageWithColor:self.view.backgroundColor andSize:CGSizeMake(25, 25)]
                                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                         weakCell.imgView.image = image;
                                         [weakCell setNeedsLayout];
                                     } failure:nil];
        
        cell.imgView.layer.cornerRadius = 25.0f;
        cell.imgView.clipsToBounds = YES;
        cell.imgView.contentMode = UIViewContentModeScaleAspectFill;
        
        cell.nameLabel.text = item.name;
        cell.priceLabel.text = item.priceText;
        cell.quantityLabel.text = [NSString stringWithFormat:@"×%d", quantity];
        outCell = cell;
    } else {
        CAPickerCell *pickerCell = [tableView dequeueReusableCellWithIdentifier:@"CAPickerCell"];
        
        NSInteger quantity = ((NSNumber*)[ShopCard foodItems].allValues[(indexPath.row-1)/2]).integerValue;
        
        [pickerCell setQuantity:quantity];
        pickerCell.delegate = self;
        pickerCell.tag = (indexPath.row-1)/2;
        pickerCell.pickerView.hidden = [self tableView:tableView heightForRowAtIndexPath:indexPath] == 0;
        
        outCell = pickerCell;
    }
    
    return outCell;
}

-(void)pickerCell:(CAPickerCell *)picker didUpdateQuanatity:(NSInteger)quantity {
    CAItemCell* cell = (CAItemCell*)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:picker.tag*2 inSection:0]];
    CAItem *item = [ShopCard foodItems].allKeys[picker.tag];
    [ShopCard setQuantity:quantity ForItem:item];
    cell.quantityLabel.text = [NSString stringWithFormat:@"x%d", quantity];
    [self updateGrandtotal];
}

@end
