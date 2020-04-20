//
//  SIMInputConfig.m
//  SIMIM
//
//  Created by ZIKong on 2019/9/17.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import "SIMInputConfig.h"
#import "SIMMediaItem.h"
#import "SIMInputDef.h"

@implementation SIMInputConfig
-(instancetype)init {
    self = [super init];
    if (self) {
        [self applyDefaultSettings];
    }
    return self;
}

- (void)applyDefaultSettings
{
    _recordMaxDuration = 60.f;
    _placeholder       = @"请输入消息";
    _inputMaxLength    = 2000;
    _inputAlignment    = SIMInputAlignmentBottom;
}

-(NSArray<SIMMediaItem *> *)mediaItems {
    SIMMediaItem *picture = [SIMMediaItem item:@"onTapMediaItemPicture:"
                              normalImage:[UIImage imageNamed:@"bk_media_picture_normal"]
                            selectedImage:[UIImage imageNamed:@"bk_media_picture_nomal_pressed"]
                                    title:@"相册"];
    
    SIMMediaItem *move = [SIMMediaItem item:@"onTapMediaItemShoot:"
                             normalImage:[UIImage imageNamed:@"bk_media_shoot_normal"]
                           selectedImage:[UIImage imageNamed:@"bk_media_shoot_pressed"]
                                   title:@"拍摄"];
    
    SIMMediaItem *location =  [SIMMediaItem item:@"onTapMediaItemLocation:"
                                     normalImage:[UIImage imageNamed:@"bk_media_position_normal"]
                                   selectedImage:[UIImage imageNamed:@"bk_media_position_pressed"]
                                           title:@"位置"];
    
    return @[picture,move,location];
}

- (NSArray<NSNumber *> *)inputBarItemTypes{
    return @[
             @(SIMInputBarItemTypeVoice),
             @(SIMInputBarItemTypeTextAndRecord),
             @(SIMInputBarItemTypeEmoticon),
             @(SIMInputBarItemTypeMore)
             ];
}

@end
