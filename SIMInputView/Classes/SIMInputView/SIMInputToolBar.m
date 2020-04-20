//
//  SIMInputToolBar.m
//  SIMIM
//
//  Created by ZIKong on 2019/9/11.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import "SIMInputToolBar.h"
#import "SIMInputTextView.h"
#import "SIMInputDef.h"
#import "UIView+SIMInputFrame.h"

@interface SIMInputToolBar ()<SIMInputTextViewDelegate,UITextViewDelegate>
@property (nonatomic , copy)   NSArray<NSNumber *> *types;
@property (nonatomic , copy)   NSDictionary *dict;

@property (nonatomic , strong) SIMInputTextView *inputTextView;

@property (nonatomic , assign) SIMInputStatus status;

@end

@implementation SIMInputToolBar

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        _voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_voiceButton setImage:[UIImage imageNamed:@"chat_voice"] forState:UIControlStateNormal];
        [_voiceButton setImage:[UIImage imageNamed:@"chat_voice"] forState:UIControlStateHighlighted];
        [_voiceButton sizeToFit];
        
        
        _emoticonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_emoticonBtn setImage:[UIImage imageNamed:@"chat_emoji"] forState:UIControlStateNormal];
        [_emoticonBtn setImage:[UIImage imageNamed:@"chat_emoji"] forState:UIControlStateHighlighted];
        [_emoticonBtn sizeToFit];
        
        _moreMediaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreMediaBtn setImage:[UIImage imageNamed:@"chat_add"] forState:UIControlStateNormal];
        [_moreMediaBtn setImage:[UIImage imageNamed:@"chat_add"] forState:UIControlStateHighlighted];
        [_moreMediaBtn sizeToFit];
        
        _recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_recordButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_recordButton.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        [_recordButton setBackgroundImage:[[UIImage imageNamed:@"icon_input_text_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(15,80,15,80) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
        _recordButton.exclusiveTouch = YES;
        [_recordButton sizeToFit];
        
        _inputTextBkgImage = [[UIImageView alloc] initWithFrame:CGRectZero];
//        [_inputTextBkgImage setImage:[[UIImage imageNamed:@"icon_input_text_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(15,80,15,80) resizingMode:UIImageResizingModeStretch]];
        [_inputTextBkgImage setImage:nil];
        
        SIMInputTextView * textView  = [[SIMInputTextView alloc] initWithFrame:CGRectZero];
        self.inputTextView = textView;
        textView.backgroundColor = [UIColor whiteColor];
        textView.font      = [UIFont systemFontOfSize:SIMInputViewFontValue];
        textView.textColor = [UIColor blackColor];
        textView.lineNum   = 5;
        textView.textViewDelegate    = self;
        textView.delegate            = self;
        textView.layer.masksToBounds = YES;
        textView.layer.cornerRadius  = 5.0f;
        textView.layer.borderWidth = 0.5;
        textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textView.returnKeyType     = UIReturnKeySend;
        [self addSubview:textView];
        
        //顶部分割线
        UIView *sep = [[UIView alloc] initWithFrame:CGRectZero];
        sep.backgroundColor = [UIColor lightGrayColor];
        sep.input_size = CGSizeMake(self.input_width, .5f);
        sep.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:sep];
        
        //底部分割线
        _bottomSep = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomSep.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_bottomSep];
        
        self.types = @[
                       @(SIMInputBarItemTypeVoice),
                       @(SIMInputBarItemTypeTextAndRecord),
                       @(SIMInputBarItemTypeEmoticon),
                       @(SIMInputBarItemTypeMore),
                       ];
    }
    return self;
}

-(void)update:(SIMInputStatus)status {
    self.status = status;
    [self sizeToFit];
    
    if (status == SIMInputStatusText || status == SIMInputStatusMore)
    {
        [self.recordButton      setHidden:YES];
        [self.inputTextView     setHidden:NO];
        [self.inputTextBkgImage setHidden:NO];
        [self updateVoiceBtnImages:YES];
        [self updateEmotAndTextBtnImages:YES];
    }
    else if(status == SIMInputStatusAudio)
    {
        [self.recordButton      setHidden:NO];
        [self.inputTextView     setHidden:YES];
        [self.inputTextBkgImage setHidden:YES];
        [self updateVoiceBtnImages:NO];
        [self updateEmotAndTextBtnImages:YES];
    }
    else
    {
        [self.recordButton      setHidden:YES];
        [self.inputTextView     setHidden:NO];
        [self.inputTextBkgImage setHidden:NO];
        [self updateVoiceBtnImages:YES];
        [self updateEmotAndTextBtnImages:YES];
    }
}

- (void)updateVoiceBtnImages:(BOOL)selected
{
    [self.voiceButton setImage:selected?[UIImage imageNamed:@"chat_voice"]:[UIImage imageNamed:@"chat_keyboard"] forState:UIControlStateNormal];
    [self.voiceButton setImage:selected?[UIImage imageNamed:@"chat_voice"]:[UIImage imageNamed:@"chat_keyboard"] forState:UIControlStateHighlighted];
}

- (void)updateEmotAndTextBtnImages:(BOOL)selected
{
    [self.emoticonBtn setImage:selected?[UIImage imageNamed:@"chat_emoji"]:[UIImage imageNamed:@"chat_keyboard"] forState:UIControlStateNormal];
    [self.emoticonBtn setImage:selected?[UIImage imageNamed:@"chat_emoji"]:[UIImage imageNamed:@"chat_keyboard"] forState:UIControlStateHighlighted];
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGFloat viewHeight = 0.0f;
    if (self.status == SIMInputStatusAudio) {
        viewHeight = 54.5;
    }else{
        //算出 TextView 的宽度
        [self adjustTextViewWidth:size.width];
        // TextView 自适应高度
        [self.inputTextView layoutIfNeeded];
        viewHeight = (int)self.inputTextView.frame.size.height+6;
        //得到 ToolBar 自身高度
        viewHeight = viewHeight + 2 * self.spacing + 2 * self.textViewPadding;
    }
    
    return CGSizeMake(size.width,viewHeight);
}

- (void)adjustTextViewWidth:(CGFloat)width
{
    CGFloat textViewWidth = 0;
    for (NSNumber *type in self.types) {
        if (type.integerValue == SIMInputBarItemTypeTextAndRecord) {
            continue;
        }
        UIView *view = [self subViewForType:type.integerValue];
        textViewWidth += view.input_width;
    }
    textViewWidth += (self.spacing * (self.types.count + 1));
    self.inputTextView.input_width  = width  - textViewWidth - 2 * self.textViewPadding;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if ([self.types containsObject:@(SIMInputBarItemTypeTextAndRecord)]) {
        self.inputTextBkgImage.input_width  = self.inputTextView.input_width  + 2 * self.textViewPadding;
        self.inputTextBkgImage.input_height = self.inputTextView.input_height + 2 * self.textViewPadding;
    }
    CGFloat left = 0;
    for (NSNumber *type in self.types) {
        UIView *view  = [self subViewForType:type.integerValue];
        if (!view.superview)
        {
            [self addSubview:view];
        }
        
        view.input_left = left + self.spacing;
        if (type.integerValue == SIMInputBarItemTypeTextAndRecord) {
            view.input_centerY = self.input_height * .5f;
        }
        else {
            view.input_top = self.spacing;
        }
        left = view.input_right;
    }
    
    [self adjustTextAndRecordView];
    
    //底部分割线
    CGFloat sepHeight = .5f;
    _bottomSep.input_size     = CGSizeMake(self.input_width, sepHeight);
    _bottomSep.input_bottom   = self.input_height - sepHeight;
}

- (void)adjustTextAndRecordView
{
    if ([self.types containsObject:@(SIMInputBarItemTypeTextAndRecord)])
    {
        self.inputTextView.center  = self.inputTextBkgImage.center;
        
        if (!self.inputTextView.superview)
        {
            //输入框
            [self addSubview:self.inputTextView];
        }
        if (!self.recordButton.superview)
        {
            //中间点击录音按钮
            self.recordButton.frame    = self.inputTextBkgImage.frame;
            [self addSubview:self.recordButton];
        }
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    BOOL should = YES;
    if ([self.delegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        should = [self.delegate textViewShouldBeginEditing];
    }
    return should;
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    BOOL should = YES;
    if ([self.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        should = [self.delegate shouldChangeTextInRange:range replacementText:text];
    }
    return should;
}

- (BOOL)showsKeyboard
{
    return [self.inputTextView isFirstResponder];
}

- (void)setShowsKeyboard:(BOOL)showsKeyboard
{
    if (showsKeyboard)
    {
        [self.inputTextView becomeFirstResponder];
    }
    else
    {
        [self.inputTextView resignFirstResponder];
    }
}

- (void)willChangeHeight:(CGFloat)height
{
    CGFloat toolBarHeight = height + 2 * self.spacing;
    if ([self.delegate respondsToSelector:@selector(toolBarWillChangeHeight:)]) {
        [self.delegate toolBarWillChangeHeight:toolBarHeight];
    }
}

- (void)didChangeHeight:(CGFloat)height
{
    NSLog(@"inputToolBar didChangeHeight:%lf",height);
    self.input_height = height + 2 * self.spacing + 2 * self.textViewPadding;
    if ([self.delegate respondsToSelector:@selector(toolBarDidChangeHeight:)]) {
        [self.delegate toolBarDidChangeHeight:self.input_height];
    }
}

-(void)emojiKeyBoardtextView:(SIMInputTextView *)textView didChangeHeight:(CGFloat)height {
    NSLog(@"textViewDidChangeHeight:%lf",height);
    self.input_height = height + 2 * self.spacing + 2 * self.textViewPadding;
    if ([self.delegate respondsToSelector:@selector(toolBarDidChangeHeight:)]) {
        [self.delegate toolBarDidChangeHeight:self.input_height];
    }
}

- (UIView *)subViewForType:(SIMInputBarItemType)type{
    if (!_dict) {
        _dict = @{
                  @(SIMInputBarItemTypeVoice) : self.voiceButton,
                  @(SIMInputBarItemTypeTextAndRecord)  : self.inputTextBkgImage,
                  @(SIMInputBarItemTypeEmoticon) : self.emoticonBtn,
                  @(SIMInputBarItemTypeMore)     : self.moreMediaBtn
                  };
    }
    return _dict[@(type)];
}

- (CGFloat)spacing{
    return 3.f;
}

- (CGFloat)textViewPadding
{
    return 1.f;
}


//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    return nil;
//}
@end
