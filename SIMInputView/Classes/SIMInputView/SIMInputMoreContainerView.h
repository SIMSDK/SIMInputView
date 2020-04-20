//
//  SIMInputMoreContainerView.h
//  SIMIM
//
//  Created by ZIKong on 2019/9/17.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIMInputProtocol.h"
#import "SIMInputConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface SIMInputMoreContainerView : UIView
@property (nonatomic, weak) id<SIMInputConfigDelegate> config;
@property (nonatomic, weak) id<SIMInputActionDelegate> actionDelegate;
@end

NS_ASSUME_NONNULL_END
