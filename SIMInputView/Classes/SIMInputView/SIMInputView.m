//
//  SIMInputView.m
//  SIMIM
//
//  Created by ZIKong on 2019/9/11.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import "SIMInputView.h"
#import "SIMInputMoreContainerView.h"
#import "UIView+SIMInputFrame.h"
#import "SIMKeyBoardInfo.h"
@interface SIMInputView ()<SIMInputToolBarDelegate>
@property (nonatomic, assign) SIMAudioRecordPhase      recordPhase;
@property (nonatomic, strong) id<SIMInputConfigDelegate> inputConfig;
@property (nonatomic, weak) id<SIMInputDelegate>       inputDelegate;
@property (nonatomic, weak) id<SIMInputActionDelegate> actionDelegate;


@property (nonatomic, assign) CGFloat keyBoardFrameTop; //键盘的frame的top值，屏幕高度 - 键盘高度，由于有旋转的可能，这个值只有当 键盘弹出时才有意义。

@end

@implementation SIMInputView

-(void)dealloc {
    _inputConfig = nil;
    NSLog(@"♻️ Dealloc %@", NSStringFromClass([self class]));
}

-(instancetype)initWithFrame:(CGRect)frame config:(id<SIMInputConfigDelegate>)config {
    self = [super initWithFrame:frame];
    if (self)
    {
        _recording = NO;
        _recordPhase = AudioRecordPhaseEnd;
//        _atCache = [[NIMInputAtCache alloc] init];
        self.inputConfig = config;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}



//-(instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        _recording = NO;
//        _recordPhase = AudioRecordPhaseEnd;
//        self.backgroundColor = [UIColor whiteColor];
//    }
//    return self;
//}

- (void)didMoveToWindow
{
    [self setup];
}

- (CGSize)sizeThatFits:(CGSize)size
{
    //这里不做.语法 get 操作，会提前初始化组件导致卡顿
    CGFloat toolBarHeight = _toolBar.input_height;
    CGFloat containerHeight = 0;
    switch (self.status)
    {
        case SIMInputStatusEmoticon:
            containerHeight = _emoticonContainer.input_height;
            break;
        case SIMInputStatusMore:
            containerHeight = _moreContainer.input_height;
            break;
        default:
        {
            UIEdgeInsets safeArea = UIEdgeInsetsZero;
            if (@available(iOS 11.0, *))
            {
                safeArea = self.superview.safeAreaInsets;
            }
            NSLog(@"keyboardHeight:%f",[SIMKeyBoardInfo instance].keyboardHeight);
            //键盘是从最底下弹起的，需要减去安全区域底部的高度
            CGFloat keyboardDelta = [SIMKeyBoardInfo instance].keyboardHeight - safeArea.bottom;
        //如果键盘还没有安全区域高，容器的初始值为0；否则则为键盘和安全区域的高度差值，这样可以保证 toolBar 始终在键盘上面
            containerHeight = keyboardDelta > 0 ? keyboardDelta : 0;
        }
            break;
    }
    CGFloat height = toolBarHeight + containerHeight;
    CGFloat width = self.superview? self.superview.input_width : self.input_width;
    return CGSizeMake(width, height);
}

- (void)setup {
    if (!_toolBar) {
        _toolBar = [[SIMInputToolBar alloc] initWithFrame:CGRectMake(0, 0, self.input_width, 0)];
        _toolBar.delegate = self;
    }
    [self addSubview:_toolBar];
    
    [_toolBar.emoticonBtn addTarget:self action:@selector(onTouchEmoticonBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar.moreMediaBtn addTarget:self action:@selector(onTouchMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar.voiceButton addTarget:self action:@selector(onTouchVoiceBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar.recordButton addTarget:self action:@selector(onTouchRecordBtnDown:) forControlEvents:UIControlEventTouchDown];
    [_toolBar.recordButton addTarget:self action:@selector(onTouchRecordBtnDragInside:) forControlEvents:UIControlEventTouchDragInside];
    [_toolBar.recordButton addTarget:self action:@selector(onTouchRecordBtnDragOutside:) forControlEvents:UIControlEventTouchDragOutside];
    [_toolBar.recordButton addTarget:self action:@selector(onTouchRecordBtnUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar.recordButton addTarget:self action:@selector(onTouchRecordBtnUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
    _toolBar.input_size = [_toolBar sizeThatFits:CGSizeMake(self.input_width, CGFLOAT_MAX)];
    _toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_toolBar.recordButton setTitle:@"按住说话" forState:UIControlStateNormal];
    [_toolBar.recordButton setHidden:YES];
    
    [self refreshStatus:SIMInputStatusText];
    [self sizeToFit];
}

- (void)reset {
    self.input_width = self.superview.input_width;
    [self refreshStatus:SIMInputStatusText];
    [self sizeToFit];
}

-(void)refreshStatus:(SIMInputStatus)status {
    self.status = status;
    [self.toolBar update:status];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.moreContainer.hidden     = status != SIMInputStatusMore;
        self.emoticonContainer.hidden = status != SIMInputStatusEmoticon;
    });
}

#pragma mark - private methods

- (void)setFrame:(CGRect)frame
{
    CGFloat height = self.frame.size.height;
    [super setFrame:frame];
    if (frame.size.height != height)
    {
        [self callDidChangeHeight];
    }
}

- (void)callDidChangeHeight
{
    if (_inputDelegate && [_inputDelegate respondsToSelector:@selector(didChangeInputHeight:)])
    {
        if (self.status == SIMInputStatusMore || self.status == SIMInputStatusEmoticon || self.status == SIMInputStatusAudio)
        {
            //这个时候需要一个动画来模拟键盘
            [UIView animateWithDuration:0.25 delay:0 options:7 animations:^{
                [self->_inputDelegate didChangeInputHeight:self.input_height];
            } completion:nil];
        }
        else
        {
            [_inputDelegate didChangeInputHeight:self.input_height];
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //这里不做.语法 get 操作，会提前初始化组件导致卡顿
    _moreContainer.input_top     = self.toolBar.input_bottom;
    _emoticonContainer.input_top = self.toolBar.input_bottom;
}

- (void)setInputConfig:(id<SIMInputConfigDelegate>)inputConfig {
    _inputConfig = inputConfig;
}

- (void)setInputDelegate:(id<SIMInputDelegate>)delegate
{
    _inputDelegate = delegate;
}

- (void)setInputActionDelegate:(id<SIMInputActionDelegate>)actionDelegate
{
    _actionDelegate = actionDelegate;
}


- (BOOL)endEditing:(BOOL)force
{
    NSLog(@"inputView endEditing");
    BOOL endEditing = [super endEditing:force];
    if (!self.toolBar.showsKeyboard) {
        UIViewAnimationCurve curve = UIViewAnimationCurveEaseInOut;
        void(^animations)(void) = ^{
            [self refreshStatus:SIMInputStatusText];
            [self sizeToFit];
            if (self.inputDelegate && [self.inputDelegate respondsToSelector:@selector(didChangeInputHeight:)]) {
                [self.inputDelegate didChangeInputHeight:self.input_height];
            }
        };
        NSTimeInterval duration = 0.25;
        [UIView animateWithDuration:duration delay:0.0f options:(curve << 16 | UIViewAnimationOptionBeginFromCurrentState) animations:animations completion:nil];
    }
    return endEditing;
}

#pragma mark - SIMInputToolBarDelegate

- (BOOL)textViewShouldBeginEditing
{
    [self refreshStatus:SIMInputStatusText];
    return YES;
}

- (void)textViewDidChange {
    
}

- (void)toolBarWillChangeHeight:(CGFloat)height {
    
}

- (void)toolBarDidChangeHeight:(CGFloat)height
{
    [self sizeToFit];
}


- (BOOL)shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)replacementText {
    return YES;
}



#pragma mark - toolBar button click function
- (void)onTouchEmoticonBtn:(id)sender
{
    if (self.status != SIMInputStatusEmoticon) {
        if ([self.actionDelegate respondsToSelector:@selector(onTapEmoticonBtn:)]) {
            [self.actionDelegate onTapEmoticonBtn:sender];
        }
        [self checkEmoticonContainer];
        [self bringSubviewToFront:self.emoticonContainer];
        [self.emoticonContainer setHidden:NO];
        [self.moreContainer setHidden:YES];
        [self refreshStatus:SIMInputStatusEmoticon];
        [self sizeToFit];
        
        
        if (self.toolBar.showsKeyboard)
        {
            self.toolBar.showsKeyboard = NO;
        }
    }
    else
    {
        [self refreshStatus:SIMInputStatusText];
        self.toolBar.showsKeyboard = YES;
    }
}

- (void)checkEmoticonContainer
{
}

- (void)onTouchMoreBtn:(id)sender {
    if (self.status != SIMInputStatusMore)
    {
        if ([self.actionDelegate respondsToSelector:@selector(onTapMoreBtn:)]) {
            [self.actionDelegate onTapMoreBtn:sender];
        }
        [self checkMoreContainer];
        [self bringSubviewToFront:self.moreContainer];
        [self.moreContainer setHidden:NO];
        [self.emoticonContainer setHidden:YES];
        [self refreshStatus:SIMInputStatusMore];
        [self sizeToFit];
        
        if (self.toolBar.showsKeyboard)
        {
            self.toolBar.showsKeyboard = NO;
        }
    }
    else
    {
        [self refreshStatus:SIMInputStatusText];
        self.toolBar.showsKeyboard = YES;
    }
}

- (void)checkMoreContainer
{
    if (!_moreContainer) {
        SIMInputMoreContainerView *moreContainer = [[SIMInputMoreContainerView alloc] initWithFrame:CGRectZero];
        moreContainer.input_size = [moreContainer sizeThatFits:CGSizeMake(self.input_width, CGFLOAT_MAX)];
        moreContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        moreContainer.hidden   = YES;
        moreContainer.config   = _inputConfig;
        moreContainer.actionDelegate = self.actionDelegate;
        _moreContainer = moreContainer;
    }
    
    //可能是外部主动设置进来的，统一放在这里添加 subview
    if (!_moreContainer.superview)
    {
        [self addSubview:_moreContainer];
    }
}
@end
