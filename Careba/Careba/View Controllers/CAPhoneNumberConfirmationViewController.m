//
//  CAPhoneNumberConfirmation.m
//  Careba
//
//  Created by Dmitry Kurilo on 12/26/14.
//  Copyright (c) 2014 Dmitry Kurilo. All rights reserved.
//

#import "CAPhoneNumberConfirmationViewController.h"
#import "CountryPicker.h"
#import "NBPhoneNumberUtil.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@import CoreTelephony;

@interface CAPhoneNumberConfirmationViewController () <CountryPickerDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *countryCodeInput;
@property (weak, nonatomic) IBOutlet UITextField *numberInput;

- (IBAction)cancel:(id)sender;
- (IBAction)getCode:(id)sender;

@property NSString *currentCountryCode;
@property NSString *currentCallingCode;

@end

@implementation CAPhoneNumberConfirmationViewController {
    NBPhoneNumberUtil *_numberUtils;
    CountryPicker *_picker;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self applyWhiteStyle];
}


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self applyBlackStyle];
}

-(void)countryPicker:(CountryPicker *)picker didSelectCountryWithName:(NSString *)name code:(NSString *)code {
    [self setCurrentCountryCode:code];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _picker = [[CountryPicker alloc] init];

    
    _countryCodeInput.delegate = self;
    [_countryCodeInput setTintColor:[UIColor clearColor]];
    
    [RACObserve(self, currentCountryCode) subscribeNext:^(NSString *newName) {
        [self setCurrentCallingCode:[[Constants countryCodes] objectForKey:_currentCountryCode]];
    }];
    
    [RACObserve(self, currentCallingCode) subscribeNext:^(NSString *newName) {
        _countryCodeInput.text = [NSString stringWithFormat:@"+%@", _currentCallingCode];
        [_countryCodeInput invalidateIntrinsicContentSize];
        //[_countryCodeInput layoutIfNeeded];
    }];
    
    CTTelephonyNetworkInfo *network_Info = [CTTelephonyNetworkInfo new];
    CTCarrier *carrier = network_Info.subscriberCellularProvider;
    
    [self setCurrentCountryCode:carrier.isoCountryCode.uppercaseString];
    
    //[_picker selectRow:[[CountryPicker countryCodes] indexOfObject:_currentCountryCode] inComponent:0 animated:NO];
    
    _picker.delegate = self;
    _countryCodeInput.inputView = _picker;
    
    //_numberInput.leftView = _countryCodeInput;
    
    [self applyBigNavBarStyle];

    
    self.title = @"Введите номер телефона";
}

-(void)viewDidAppear:(BOOL)animated {
    [_numberInput becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)getCode:(id)sender {
    [self performSegueWithIdentifier:@"numberToCard" sender:self];
}
@end
