//
//  CACheckoutNextCell.h
//  Careba
//
//  Created by Dmitry Kurilo on 3/9/15.
//  Copyright (c) 2015 Dmitry Kurilo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CACheckoutNextCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tickImageView;

-(void)setTickHidden:(BOOL)hidden;

@end
