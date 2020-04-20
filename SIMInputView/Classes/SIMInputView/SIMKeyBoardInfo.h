//
//  SIMKeyBoardInfo.h
//  SIMIM
//
//  Created by ZIKong on 2019/9/11.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SIMKeyBoardInfo : NSObject
//是否可见
@property (nonatomic,assign,readonly) CGFloat isVisiable;

//键盘高度
@property (nonatomic,assign,readonly) CGFloat keyboardHeight;

+ (instancetype)instance;


UIKIT_EXTERN NSNotificationName const SIMKeyboardWillChangeFrameNotification;
UIKIT_EXTERN NSNotificationName const SIMKeyboardWillHideNotification;

@end

NS_ASSUME_NONNULL_END
