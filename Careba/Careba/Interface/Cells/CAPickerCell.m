//
//  CAPickerCell.m
//  Careba
//
//  Created by Dmitry Kurilo on 3/3/15.
//  Copyright (c) 2015 Dmitry Kurilo. All rights reserved.
//

#import "CAPickerCell.h"

@interface CAPickerCell() <UIPickerViewDataSource, UIPickerViewDelegate>


@end

@implementation CAPickerCell

-(void)awakeFromNib {
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 98;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [_delegate pickerCell:self didUpdateQuanatity:row+1];
}

-(void)setQuantity:(NSInteger)quantity {
    [_pickerView selectRow:quantity-1 inComponent:0 animated:NO];
}


-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%d", row+1];
}

@end
