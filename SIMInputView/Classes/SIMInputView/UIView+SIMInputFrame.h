//
//  UIView+SIMInputFrame.h
//  SIMIM
//
//  Created by ZIKong on 2019/9/11.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SIMInputFrame)
@property (nonatomic) CGFloat input_x;
@property (nonatomic) CGFloat input_y;
@property (nonatomic) CGFloat input_left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat input_top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat input_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat input_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat input_width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat input_height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat input_centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat input_centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint input_origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  input_size;        ///< Shortcut for frame.size.


@end

NS_ASSUME_NONNULL_END
