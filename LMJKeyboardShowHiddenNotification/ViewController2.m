//
//  ViewController2.m
//  LMJKeyboardShowHiddenNotification
//
//  Created by Major on 16/9/28.
//  Copyright © 2016年 iOS开发者公会. All rights reserved.
//

#import "ViewController2.h"

#import "LMJKeyboardShowHiddenNotificationCenter.h"

@interface ViewController2 () <UITextFieldDelegate,LMJKeyboardShowHiddenNotificationCenterDelegate>
{
    UITextField * _textField;
}

@end

@implementation ViewController2

- (void)viewWillAppear:(BOOL)animated{
    // 设置代理
    [LMJKeyboardShowHiddenNotificationCenter defineCenter].delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 30)];
    [btn1 setTitle:@"上一页" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(previousPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    
    
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.height -30, [UIScreen mainScreen].bounds.size.width -20, 30)];
    _textField.placeholder       = @"这是一个输入框";
    _textField.layer.borderColor = [UIColor blackColor].CGColor;
    _textField.layer.borderWidth = 1.f;
    _textField.delegate          = self;
    [self.view addSubview:_textField];
}

- (void)previousPage{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)previousPage{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

#pragma mark - LMJKeyboardShowHiddenNotificationCenter Delegate

- (void)showOrHiddenKeyboardWithHeight:(CGFloat)height withDuration:(CGFloat)animationDuration isShow:(BOOL)isShow{
    
    NSLog(@"ViewController3 接收到%@通知\n高度值：%f\n时间：%f",isShow ? @"弹出":@"隐藏", height,animationDuration);
    
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
