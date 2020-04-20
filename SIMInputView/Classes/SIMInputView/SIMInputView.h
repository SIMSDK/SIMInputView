//
//  SIMInputView.h
//  SIMIM
//
//  Created by ZIKong on 2019/9/11.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIMInputProtocol.h"
#import "SIMInputToolBar.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SIMAudioRecordPhase) {
    AudioRecordPhaseStart,
    AudioRecordPhaseRecording,
    AudioRecordPhaseCancelling,
    AudioRecordPhaseEnd
};

@protocol SIMInputDelegate <NSObject>

@optional

- (void)didChangeInputHeight:(CGFloat)inputHeight;

@end


@interface SIMInputView : UIView

@property (assign, nonatomic, getter=isRecording)    BOOL recording;

@property (nonatomic, strong) SIMInputToolBar *toolBar;
@property (strong, nonatomic)  UIView *moreContainer;
@property (strong, nonatomic)  UIView *emoticonContainer;

@property (nonatomic, assign) SIMInputStatus status;

- (instancetype)initWithFrame:(CGRect)frame
                       config:(id<SIMInputConfigDelegate>)config;

- (void)setInputDelegate:(id<SIMInputDelegate>)delegate;

- (void)reset;

- (void)refreshStatus:(SIMInputStatus)status;

//外部设置
- (void)setInputActionDelegate:(id<SIMInputActionDelegate>)actionDelegate;

@end

NS_ASSUME_NONNULL_END
