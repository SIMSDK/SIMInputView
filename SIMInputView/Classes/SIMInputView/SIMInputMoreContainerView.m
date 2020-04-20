//
//  SIMInputMoreContainerView.m
//  SIMIM
//
//  Created by ZIKong on 2019/9/17.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import "SIMInputMoreContainerView.h"
#import "SIMPageView.h"
#import "SIMMediaItem.h"
#import "UIView+SIMInputFrame.h"

NSInteger SIMMaxItemCountInPage = 8;
NSInteger SIMButtonItemWidth    = 75;
NSInteger SIMButtonItemHeight   = 85;
NSInteger SIMPageRowCount       = 2;
NSInteger SIMPageColumnCount    = 4;
NSInteger SIMButtonBegintLeftX  = 11;

@interface SIMInputMoreContainerView ()<SIMPageViewDataSource,SIMPageViewDelegate>
{
    NSArray                 *_mediaButtons;
    NSArray                 *_mediaItems;
}

@property (nonatomic, strong) SIMPageView *pageView;
@end

@implementation SIMInputMoreContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _pageView = [[SIMPageView alloc] initWithFrame:CGRectZero];
        _pageView.dataSource = self;
        [self addSubview:_pageView];
    }
    return self;
}

- (void)setConfig:(id<SIMInputConfigDelegate>)config
{
    _config = config;
    [self genMediaButtons];
    [self.pageView reloadData];
}


- (CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake(size.width, 216.f);
}


- (void)genMediaButtons
{
    NSMutableArray *mediaButtons = [NSMutableArray array];
    NSMutableArray *mediaItems = [NSMutableArray array];
    NSArray *items;
//    if (!self.config)
//    {
//        items = [NIMKit sharedKit].config.defaultMediaItems;
//    }
//    else if([self.config respondsToSelector:@selector(mediaItems)])
//    {
//        items = [self.config mediaItems];
//    }
    if ([self.config respondsToSelector:@selector(mediaItems)]) {
        items = [self.config mediaItems];
    }
    [items enumerateObjectsUsingBlock:^(SIMMediaItem *item, NSUInteger idx, BOOL *stop) {
        [mediaItems addObject:item];
        
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = idx;
        [btn setImage:item.normalImage forState:UIControlStateNormal];
        [btn setImage:item.selectedImage forState:UIControlStateHighlighted];
        [btn setTitle:item.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(76, -75, 0, 0)];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [mediaButtons addObject:btn];
        
    }];
    _mediaButtons = mediaButtons;
    _mediaItems = mediaItems;
}

- (void)setFrame:(CGRect)frame{
    CGFloat originalWidth = self.frame.size.width;
    [super setFrame:frame];
    if (originalWidth != frame.size.width)
    {
        self.pageView.frame = self.bounds;
        [self.pageView reloadData];
    }
}

- (void)dealloc
{
    _pageView.dataSource = nil;
}


#pragma mark PageViewDataSource
- (NSInteger)numberOfPages: (SIMPageView *)pageView
{
    NSInteger count = [_mediaButtons count] / SIMMaxItemCountInPage;
    count = ([_mediaButtons count] % SIMMaxItemCountInPage == 0) ? count: count + 1;
    return MAX(count, 1);
}

- (UIView*)mediaPageView:(SIMPageView*)pageView beginItem:(NSInteger)begin endItem:(NSInteger)end
{
    UIView *subView = [[UIView alloc] init];
    NSInteger span = (self.input_width - SIMPageColumnCount * SIMButtonItemWidth) / (SIMPageColumnCount +1);
    CGFloat startY          = SIMButtonBegintLeftX;
    NSInteger coloumnIndex = 0;
    NSInteger rowIndex = 0;
    NSInteger indexInPage = 0;
    for (NSInteger index = begin; index < end; index ++)
    {
        UIButton *button = [_mediaButtons objectAtIndex:index];
        [button addTarget:self action:@selector(onTouchButton:) forControlEvents:UIControlEventTouchUpInside];
        //计算位置
        rowIndex    = indexInPage / SIMPageColumnCount;
        coloumnIndex= indexInPage % SIMPageColumnCount;
        CGFloat x = span + (SIMButtonItemWidth + span) * coloumnIndex;
        CGFloat y = 0.0;
        if (rowIndex > 0)
        {
            y = rowIndex * SIMButtonItemHeight + startY + 15;
        }
        else
        {
            y = rowIndex * SIMButtonItemHeight + startY;
        }
        [button setFrame:CGRectMake(x, y, SIMButtonItemWidth, SIMButtonItemHeight)];
        [subView addSubview:button];
        indexInPage ++;
    }
    return subView;
}

- (UIView*)oneLineMediaInPageView:(SIMPageView *)pageView
                       viewInPage: (NSInteger)index
                            count:(NSInteger)count
{
    UIView *subView = [[UIView alloc] init];
    NSInteger span = (self.input_width - count * SIMButtonItemWidth) / (count +1);
    
    for (NSInteger btnIndex = 0; btnIndex < count; btnIndex ++)
    {
        UIButton *button = [_mediaButtons objectAtIndex:btnIndex];
        [button addTarget:self action:@selector(onTouchButton:) forControlEvents:UIControlEventTouchUpInside];
        CGRect iconRect = CGRectMake(span + (SIMButtonItemWidth + span) * btnIndex, 58, SIMButtonItemWidth, SIMButtonItemHeight);
        [button setFrame:iconRect];
        [subView addSubview:button];
    }
    return subView;
}

- (UIView *)pageView: (SIMPageView *)pageView viewInPage: (NSInteger)index
{
    if ([_mediaButtons count] == 2 || [_mediaButtons count] == 3) //一行显示2个或者3个
    {
        return [self oneLineMediaInPageView:pageView viewInPage:index count:[_mediaButtons count]];
    }
    
    if (index < 0)
    {
        assert(0);
        index = 0;
    }
    NSInteger begin = index * SIMMaxItemCountInPage;
    NSInteger end = (index + 1) * SIMMaxItemCountInPage;
    if (end > [_mediaButtons count])
    {
        end = [_mediaButtons count];
    }
    return [self mediaPageView:pageView beginItem:begin endItem:end];
}

#pragma mark - button actions
- (void)onTouchButton:(id)sender
{
    NSInteger index = [(UIButton *)sender tag];
    SIMMediaItem *item = _mediaItems[index];
    if (_actionDelegate && [_actionDelegate respondsToSelector:@selector(onTapMediaItem:)]) {
        BOOL handled = [_actionDelegate onTapMediaItem:item];
        if (!handled) {
            NSAssert(0, @"invalid item selector!");
        }
    }
    
}

@end
