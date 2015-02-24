//
//  CAFoodCellSingle.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/26/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "CAFoodCellSingle.h"

@interface CAFoodCellSingle()
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
- (IBAction)plusButtonHit:(id)sender;

@end

@implementation CAFoodCellSingle

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)plusButtonHit:(id)sender {
    _plusButton.selected = !_plusButton.selected;
}
@end
