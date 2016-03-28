//
//  LMJKeyboardShowHiddenNotificationCenter.m
//
//  Created by MajorLi on 15/3/9.
//  Copyright © 2015年 iOS开发者公会. All rights reserved.
//
//  iOS开发者公会-技术1群 QQ群号：87440292
//  iOS开发者公会-技术2群 QQ群号：232702419
//  iOS开发者公会-议事区  QQ群号：413102158
//

#import "LMJKeyboardShowHiddenNotificationCenter.h"

@implementation LMJKeyboardShowHiddenNotificationCenter


+ (LMJKeyboardShowHiddenNotificationCenter *)defineCenter{
    static LMJKeyboardShowHiddenNotificationCenter * center = nil;
    if (center == nil) {
        center = [[LMJKeyboardShowHiddenNotificationCenter alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:center selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:center selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    
    return center;
}


- (void)keyboardWillShow:(NSNotification *)notification {
    
    // 获取通知的信息字典
    NSDictionary *userInfo = [notification userInfo];
    
    // 获取键盘弹出后的rect
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    // 获取键盘弹出动画时间
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // 调用代理
    if ([self.delegate respondsToSelector:@selector(showOrHiddenKeyboardWithHeight:withDuration:isShow:)]) {
        [self.delegate showOrHiddenKeyboardWithHeight:keyboardRect.size.height withDuration:animationDuration isShow:YES];
    }
}


- (void)keyboardWillHide:(NSNotification *)notification {
    
    // 获取通知信息字典
    NSDictionary* userInfo = [notification userInfo];
    
    // 获取键盘隐藏动画时间
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // 调用代理
    if ([self.delegate respondsToSelector:@selector(showOrHiddenKeyboardWithHeight:withDuration:isShow:)]) {
        [self.delegate showOrHiddenKeyboardWithHeight:0.0 withDuration:animationDuration isShow:NO];
    }
}


//- (void)closeCurrentNotification{
//    self.delegate = nil;
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
