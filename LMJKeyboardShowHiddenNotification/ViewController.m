//
//  ViewController.m
//  LMJKeyboardShowHiddenNotification
//
//  Created by Major on 16/3/28.
//  Copyright © 2016年 iOS开发者公会. All rights reserved.
//

#import "ViewController.h"

#import "LMJKeyboardShowHiddenNotificationCenter.h"

@interface ViewController () <LMJKeyboardShowHiddenNotificationCenterDelegate,UITextFieldDelegate>
{
    UITextField * _textField;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置代理
    [LMJKeyboardShowHiddenNotificationCenter defineCenter].delegate = self;
    
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.height -30, [UIScreen mainScreen].bounds.size.width -20, 30)];
    _textField.placeholder       = @"这是一个输入框";
    _textField.layer.borderColor = [UIColor blackColor].CGColor;
    _textField.layer.borderWidth = 1.f;
    _textField.delegate          = self;
    [self.view addSubview:_textField];
    
}

#pragma mark - LMJKeyboardShowHiddenNotificationCenter Delegate

- (void)showOrHiddenKeyboardWithHeight:(CGFloat)height withDuration:(CGFloat)animationDuration isShow:(BOOL)isShow{
    [UIView animateWithDuration:animationDuration animations:^{
        [_textField setFrame:CGRectMake(_textField.frame.origin.x, [UIScreen mainScreen].bounds.size.height -30 -height, _textField.frame.size.width, _textField.frame.size.height)];
    }];
}



#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
