//
//  CAItemCell.h
//  Careba
//
//  Created by Dmitry Kurilo on 3/2/15.
//  Copyright (c) 2015 Dmitry Kurilo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CAItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextField *quantityLabel;

@end
