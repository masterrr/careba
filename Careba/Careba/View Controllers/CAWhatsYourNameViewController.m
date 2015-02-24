//
//  CAWhatsYourNameViewController.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/27/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "CAWhatsYourNameViewController.h"

@interface CAWhatsYourNameViewController ()
- (IBAction)confirm:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@end

@implementation CAWhatsYourNameViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self applyWhiteStyle];
}


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self applyBlackStyle];
}

-(void)viewDidAppear:(BOOL)animated {
    [_nameTextField becomeFirstResponder];
}

-(void)viewDidLoad {
    [self applyBigNavBarStyle];
    self.title = @"Как вас зовут?";
}

- (IBAction)confirm:(id)sender {
    [self performSegueWithIdentifier:@"nameToCard" sender:self];
}
@end
