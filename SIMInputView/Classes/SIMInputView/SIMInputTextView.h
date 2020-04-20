//
//  SIMInputTextView.h
//  SIMIM
//
//  Created by ZIKong on 2019/9/11.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SIMInputTextView;

NS_ASSUME_NONNULL_BEGIN

@protocol SIMInputTextViewDelegate <NSObject>

@optional
- (void)emojiKeyBoardtextView:(SIMInputTextView *_Nullable)textView willChangeHeight:(CGFloat)height;
- (void)emojiKeyBoardtextView:(SIMInputTextView *_Nullable)textView didChangeHeight:(CGFloat)height;
- (void)emojiKeyBoardtextView:(SIMInputTextView *_Nonnull)textView past:(NSString *_Nullable)pastStr;
@end


@interface SIMInputTextView : UITextView
@property (nonatomic , weak) id<SIMInputTextViewDelegate> textViewDelegate;
@property (nonatomic , strong) UIResponder * responder;

// 占位符
@property (nonatomic , copy)   NSString    * placeholder;
// 占位符 颜色
@property (nonatomic , strong) UIColor     * placeholderColor;
// 自动增高行数
@property (nonatomic , assign) NSUInteger    lineNum;

@end

NS_ASSUME_NONNULL_END
