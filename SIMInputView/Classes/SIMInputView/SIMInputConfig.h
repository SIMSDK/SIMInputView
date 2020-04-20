//
//  SIMInputConfig.h
//  SIMIM
//
//  Created by ZIKong on 2019/9/17.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIMInputProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SIMInputAlignment) {
    SIMInputAlignmentTop,    //上
    SIMInputAlignmentCenter, //中
    SIMInputAlignmentBottom, //下
};

@interface SIMInputConfig : NSObject<SIMInputConfigDelegate>


/**
 *  录音的最大时长
 */
@property (nonatomic, assign)  NSTimeInterval recordMaxDuration;


/**
 *  输入框的占位符
 */
@property (nonatomic, copy)  NSString *placeholder;


/**
 *  输入框能容纳的最大字符长度
 */
@property (nonatomic, assign) NSInteger inputMaxLength;


/**
 键盘视图子控件排列方式
 */
@property (nonatomic, assign) SIMInputAlignment inputAlignment;


@end

NS_ASSUME_NONNULL_END
