//
//  SIMInputProtocol.h
//  SIMIM
//
//  Created by ZIKong on 2019/9/17.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SIMMediaItem;

NS_ASSUME_NONNULL_BEGIN

@protocol SIMInputActionDelegate <NSObject>

@optional
- (BOOL)onTapMediaItem:(SIMMediaItem *)item;

- (void)onTextChanged:(id)sender;

- (void)onSendText:(NSString *)text
           atUsers:(NSArray *)atUsers;

- (void)onSelectChartlet:(NSString *)chartletId
                 catalog:(NSString *)catalogId;


- (void)onCancelRecording;

- (void)onStopRecording;

- (void)onStartRecording;

- (void)onTapMoreBtn:(id)sender;

- (void)onTapEmoticonBtn:(id)sender;

- (void)onTapVoiceBtn:(id)sender;

@end



@protocol SIMInputConfigDelegate <NSObject>

/**
 *  输入按钮类型，请填入 NIMInputBarItemType 枚举，按顺序排列。不实现则按默认排列。
 */
- (NSArray<NSNumber *> *)inputBarItemTypes;

/**
 *  可以显示在点击输入框“+”按钮之后的多媒体按钮
 */
- (NSArray<SIMMediaItem *> *)mediaItems;

@optional


@end

NS_ASSUME_NONNULL_END
