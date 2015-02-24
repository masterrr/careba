//
//  CACodeViewController.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/27/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "CACodeViewController.h"
#import "DZGImgGlyphTextView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface CACodeViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@end

@implementation CACodeViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self applyWhiteStyle];
}

-(void)viewDidAppear:(BOOL)animated {
    [_codeTextField becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self applyBlackStyle];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return textField.text.length < 4 || string.length != 1  ;
}

-(void)checkCode:(NSString*)odes {
    if ([_codeTextField.text isEqual:@"1111"]) {
        [self performSegueWithIdentifier:@"codeToName" sender:self];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Неправильный код" message:@"Попробуйте еще раз" delegate:nil cancelButtonTitle:@"Хорошо" otherButtonTitles:nil] show];
    }
    _codeTextField.text = @"";
}

-(void)viewDidLoad {
    [self applyBigNavBarStyle];
    self.title = @"Введите код из SMS";
    self.codeTextField.delegate = self;
    
    [self.codeTextField.rac_textSignal subscribeNext:^(NSString *text) {
        if (text.length == 4) {
            [self checkCode:text];
        }
    }];
}

@end
