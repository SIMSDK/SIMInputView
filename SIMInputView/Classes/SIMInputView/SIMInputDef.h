//
//  SIMInputDef.h
//  Pods
//
//  Created by zikong on 2020/4/20.
//

#ifndef SIMInputDef_h
#define SIMInputDef_h

// 此枚举: 弹出哪个视图的一个状态值
typedef NS_ENUM(NSInteger , SIMInputViewShowViewState)
{
    SIMInputViewShowViewStateVoice = 0,    //录音
    SIMInputViewShowViewStateKeyBoard,     //键盘
    SIMInputViewShowViewStateEmojiFace,    //表情
    SIMInputViewShowViewStateChatTool      //其他
};

typedef NS_ENUM(NSInteger,SIMInputBarItemType){
    SIMInputBarItemTypeVoice,         //录音文本切换按钮
    SIMInputBarItemTypeTextAndRecord, //文本输入框或录音按钮
    SIMInputBarItemTypeEmoticon,      //表情贴图
    SIMInputBarItemTypeMore,          //更多菜单
};



#define SIMInputViewBundleImage(name) [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",@"SIMInputViewBundle.bundle/",name]]

//表情最大的行数
#define SIMInputViewSignlePageView_Emjoi_MaxRow 3
//表情最大的列数
#define SIMInputViewSignlePageView_Emjoi_MaxCol 7
//单页最多的表情个数
#define SIMInputViewSignlePageView_AllEmjoiCount ((SIMInputViewSignlePageView_Emjoi_MaxRow * SIMInputViewSignlePageView_Emjoi_MaxCol) - 1)

//颜色转换
#define SIMInputViewColorRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
//键盘输入字体
#define SIMInputViewFontValue 17
#define SIMInputViewViewHeight 216  // 表情键盘高度
#define SIMInputViewViewToolBarHeight   50   // 默认键盘输入工具条的高度

// 按钮宽度
#define SIMInputViewButtonWidth 35
// 按钮高度
#define SIMInputViewButtonHeight 44
// 输入框 Y值
#define SIMInputViewTextViewY 7
// 默认输入框字体大小
#define SIMInputViewTextViewFont SIMInputViewFontValue
// 默认输入框字体颜色
#define SIMInputViewTextViewColor [UIColor blackColor]



//屏幕的宽高
#define SIMInputViewUIScreenWidth                              [UIScreen mainScreen].bounds.size.width
#define SIMInputViewUIScreenHeight                             [UIScreen mainScreen].bounds.size.height

//iPhoneX / iPhoneXS
#define  SIMInputViewisIphoneX_XS        (SIMInputViewUIScreenWidth == 375.f && SIMInputViewUIScreenHeight == 812.f ? YES : NO)
//iPhoneXR / iPhoneXSMax
#define  SIMInputViewisIphoneXR_XSMax    (SIMInputViewUIScreenWidth == 414.f && SIMInputViewUIScreenHeight == 896.f ? YES : NO)
//异性全面屏
#define   SIMInputViewisFullProfiledScreen    (SIMInputViewisIphoneX_XS || SIMInputViewisIphoneXR_XSMax)

#define SIMInputViewiPhoneX (SIMInputViewisFullProfiledScreen)


//竖屏状态
//iPhoneX状态栏的高度 44
#define SIMInputViewkState_Height (SIMInputViewisFullProfiledScreen ? 44.0 : 20.0)
//NavigationBar的高度 44
#define SIMInputViewkNavigationBar_Height 44.0
#define SIMInputViewSafeAreaTopHeight (SIMInputViewisFullProfiledScreen ? 88 : 64)
//底部非安全区域的高度 34
#define SIMInputViewkBottomNOSafeArea_Height (SIMInputViewisFullProfiledScreen ? 34.0 :0.0)
#define SIMInputViewkTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)

#define SIMInputViewkStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

#define SIMInputViewkTopHeight (SIMInputViewkStatusBarHeight + SIMInputViewkNavigationBar_Height)



#endif /* SIMInputDef_h */
