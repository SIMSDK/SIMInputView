//
//  SIMMediaItem.h
//  SIMIM
//
//  Created by ZIKong on 2019/9/17.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SIMMediaItem : NSObject

@property (nonatomic,assign)    SEL selctor;

@property (nonatomic,strong)    UIImage *normalImage;

@property (nonatomic,strong)    UIImage *selectedImage;

@property (nonatomic,copy)      NSString *title;

+ (SIMMediaItem *)item:(NSString *)selector
           normalImage:(UIImage  *)normalImage
         selectedImage:(UIImage  *)selectedImage
                 title:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
