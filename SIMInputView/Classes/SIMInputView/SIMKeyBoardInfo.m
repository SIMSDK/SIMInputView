//
//  SIMKeyBoardInfo.m
//  SIMIM
//
//  Created by ZIKong on 2019/9/11.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import "SIMKeyBoardInfo.h"

NSNotificationName const SIMKeyboardWillChangeFrameNotification = @"SIMKeyboardWillChangeFrameNotification";
NSNotificationName const SIMKeyboardWillHideNotification        = @"SIMKeyboardWillHideNotification";

@implementation SIMKeyBoardInfo

@synthesize keyboardHeight = _keyboardHeight;

+ (instancetype)instance
{
    static SIMKeyBoardInfo *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SIMKeyBoardInfo alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame   = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _isVisiable = endFrame.origin.y != [UIApplication sharedApplication].keyWindow.frame.size.height;
    _keyboardHeight = _isVisiable? endFrame.size.height: 0;
    [[NSNotificationCenter defaultCenter] postNotificationName:SIMKeyboardWillChangeFrameNotification object:nil userInfo:notification.userInfo];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    _isVisiable     = NO;
    _keyboardHeight = 0;
    [[NSNotificationCenter defaultCenter] postNotificationName:SIMKeyboardWillHideNotification object:nil userInfo:notification.userInfo];
}

@end
