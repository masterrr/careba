//
//  CAOrderStatusCell.h
//  Careba
//
//  Created by Dmitry Kurilo on 3/13/15.
//  Copyright (c) 2015 Dmitry Kurilo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAOrderStatusCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *foodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end
