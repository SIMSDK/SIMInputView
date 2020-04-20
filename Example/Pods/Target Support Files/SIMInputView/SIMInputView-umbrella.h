#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "SIMInputProtocol.h"
#import "SIMInput.h"
#import "SIMInputConfig.h"
#import "SIMInputDef.h"
#import "SIMInputMoreContainerView.h"
#import "SIMInputTextView.h"
#import "SIMInputToolBar.h"
#import "SIMInputView.h"
#import "SIMKeyBoardInfo.h"
#import "SIMMediaItem.h"
#import "SIMPageView.h"
#import "UIView+SIMInputFrame.h"

FOUNDATION_EXPORT double SIMInputViewVersionNumber;
FOUNDATION_EXPORT const unsigned char SIMInputViewVersionString[];

