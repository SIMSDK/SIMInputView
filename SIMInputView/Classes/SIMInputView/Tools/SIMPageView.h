//
//  SIMPageView.h
//  SIMIM
//
//  Created by ZIKong on 2019/9/16.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SIMPageView;

NS_ASSUME_NONNULL_BEGIN


@protocol SIMPageViewDataSource <NSObject>

- (NSInteger)numberOfPages: (SIMPageView *)pageView;
- (UIView *)pageView: (SIMPageView *)pageView viewInPage: (NSInteger)index;

@end

@protocol SIMPageViewDelegate <NSObject>
@optional
- (void)pageViewScrollEnd: (SIMPageView *)pageView
             currentIndex: (NSInteger)index
               totolPages: (NSInteger)pages;

- (void)pageViewDidScroll: (SIMPageView *)pageView;
- (BOOL)needScrollAnimation;
@end

@interface SIMPageView : UIView<UIScrollViewDelegate>
@property (nonatomic,strong)    UIScrollView   *scrollView;
@property (nonatomic,weak)    id<SIMPageViewDataSource>  dataSource;
@property (nonatomic,weak)    id<SIMPageViewDelegate>    pageViewDelegate;
- (void)scrollToPage: (NSInteger)pages;
- (void)reloadData;
- (UIView *)viewAtIndex: (NSInteger)index;
- (NSInteger)currentPage;


//旋转相关方法,这两个方法必须配对调用,否则会有问题
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration;

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration;


@end

NS_ASSUME_NONNULL_END
