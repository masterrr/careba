//
//  CACafeListViewController.h
//  Careba
//
//  Created by Dmitry Kurilo on 12/10/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YandexMapKit/YandexMapKit.h>


@interface CACafeListViewController : UIViewController <UITableViewDelegate,UITableViewDataSource, YMKMapViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SlideNavigationControllerDelegate>

@end
