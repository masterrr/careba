//
//  CAFoodCellSingle.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/26/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "CAFoodCellSingle.h"
#import "UIImageView+AFNetworking.h"


@interface CAFoodCellSingle()
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
- (IBAction)plusButtonHit:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) CAItem *item;

@end

@implementation CAFoodCellSingle

- (void)awakeFromNib {
    // Initialization code
}

-(void)setItem:(CAItem*)item {
    _item = item;
    _titleLabel.text = item.name;
    [_imageView setImageWithURL:item.imageNSURL];
}

- (IBAction)plusButtonHit:(id)sender {
    _plusButton.selected = !_plusButton.selected;
}
@end
