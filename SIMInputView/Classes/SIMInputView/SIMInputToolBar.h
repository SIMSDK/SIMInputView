//
//  SIMInputToolBar.h
//  SIMIM
//
//  Created by ZIKong on 2019/9/11.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, SIMInputStatus) {
    SIMInputStatusText,
    SIMInputStatusAudio,
    SIMInputStatusEmoticon,
    SIMInputStatusMore
};

NS_ASSUME_NONNULL_BEGIN


@protocol SIMInputToolBarDelegate <NSObject>

@optional

- (BOOL)textViewShouldBeginEditing;

- (void)textViewDidEndEditing;

- (BOOL)shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)replacementText;

- (void)textViewDidChange;

- (void)toolBarWillChangeHeight:(CGFloat)height;

- (void)toolBarDidChangeHeight:(CGFloat)height;

@end

@interface SIMInputToolBar : UIView

@property (nonatomic,strong) UIButton    *voiceButton;

@property (nonatomic,strong) UIButton    *emoticonBtn;

@property (nonatomic,strong) UIButton    *moreMediaBtn;

@property (nonatomic,strong) UIButton    *recordButton;

@property (nonatomic,strong) UIImageView *inputTextBkgImage;

@property (nonatomic,copy)   NSString    *contentText;

@property (nonatomic,assign) BOOL        showsKeyboard;

@property (nonatomic,assign) NSArray     *inputBarItemTypes;

@property (nonatomic,assign) NSInteger   maxNumberOfInputLines;

@property (nonatomic,strong) UIView *bottomSep;

@property (nonatomic,weak) id<SIMInputToolBarDelegate> delegate;

- (void)update:(SIMInputStatus)status;

@end

NS_ASSUME_NONNULL_END
