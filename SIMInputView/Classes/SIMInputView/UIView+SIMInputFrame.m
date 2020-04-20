//
//  UIView+SIMInputFrame.m
//  SIMIM
//
//  Created by ZIKong on 2019/9/11.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import "UIView+SIMInputFrame.h"

@implementation UIView (SIMInputFrame)
-(CGFloat)input_x {
    return self.frame.origin.x;
}

-(void)setInput_x:(CGFloat)input_x {
    CGRect frame=self.frame;
    frame.origin.x=input_x;
    self.frame=frame;
}

-(CGFloat)input_y {
    return self.frame.origin.y;
}

-(void)setInput_y:(CGFloat)input_y {
    CGRect frame=self.frame;
    frame.origin.y=input_y;
    self.frame=frame;
}

-(CGFloat)input_left {
    return self.frame.origin.x;
}

-(void)setInput_left:(CGFloat)input_left {
    CGRect frame = self.frame;
    frame.origin.x = input_left;
    self.frame = frame;
}

-(CGFloat)input_top {
    return self.frame.origin.y;
}

-(void)setInput_top:(CGFloat)input_top {
    CGRect frame = self.frame;
    frame.origin.y = input_top;
    self.frame = frame;
}

-(CGFloat)input_right {
    return self.frame.origin.x + self.frame.size.width;
}

-(void)setInput_right:(CGFloat)input_right {
    CGRect frame = self.frame;
    frame.origin.x = input_right - frame.size.width;
    self.frame = frame;
}

-(CGFloat)input_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

-(void)setInput_bottom:(CGFloat)input_bottom {
    CGRect frame = self.frame;
    frame.origin.y = input_bottom - frame.size.height;
    self.frame = frame;
}

-(CGFloat)input_width {
    return self.frame.size.width;
}

-(void)setInput_width:(CGFloat)input_width {
    CGRect frame = self.frame;
    frame.size.width = input_width;
    self.frame = frame;
}

-(CGFloat)input_height {
    return self.frame.size.height;
}

-(void)setInput_height:(CGFloat)input_height {
    CGRect frame = self.frame;
    frame.size.height = input_height;
    self.frame = frame;
}

-(CGFloat)input_centerX {
    return self.center.x;
}

-(void)setInput_centerX:(CGFloat)input_centerX {
    self.center = CGPointMake(input_centerX, self.center.y);
}

-(CGFloat)input_centerY {
    return self.center.y;
}

-(void)setInput_centerY:(CGFloat)input_centerY {
    self.center = CGPointMake(self.center.x, input_centerY);
}

-(CGPoint)input_origin {
    return self.frame.origin;
}

-(void)setInput_origin:(CGPoint)input_origin {
    CGRect frame = self.frame;
    frame.origin = input_origin;
    self.frame = frame;
}

-(CGSize)input_size {
    return self.frame.size;
}

-(void)setInput_size:(CGSize)input_size {
    CGRect frame = self.frame;
    frame.size = input_size;
    self.frame = frame;
}


@end
