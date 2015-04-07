//
//  CAPickerCell.h
//  Careba
//
//  Created by Dmitry Kurilo on 3/3/15.
//  Copyright (c) 2015 Dmitry Kurilo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CAPickerCell;

@protocol CAPickerCellProtocol

-(void)pickerCell:(CAPickerCell*)picker didUpdateQuanatity:(NSInteger)quantity;

@end

@interface CAPickerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic, weak) id<CAPickerCellProtocol> delegate;
-(void)setQuantity:(NSInteger)quantity;

@end
