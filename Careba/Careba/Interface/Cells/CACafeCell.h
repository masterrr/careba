//
//  CACafeCell.h
//  Careba
//
//  Created by Dmitry Kurilo on 12/11/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAInsetCafeFeatureTextField.h"
#import "CAInsetCafeRatingTextField.h"

@interface CACafeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet CAInsetCafeFeatureTextField *pointsTag;
@property (weak, nonatomic) IBOutlet CAInsetCafeFeatureTextField *promotionTag;
@property (weak, nonatomic) IBOutlet UILabel *avgSumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avgSumIcon;
@property (weak, nonatomic) IBOutlet UIImageView *wifiIcon;
@property (weak, nonatomic) IBOutlet UIImageView *parkingIcon;
@property (weak, nonatomic) IBOutlet UILabel *closeTimeLabel;

@property (weak, nonatomic) IBOutlet CAInsetCafeRatingTextField *ratingLabel;

@end
