//
//  SegmentCate.h
//  ProjectTemplate
//
//  Created by 雨停 on 2017/12/4.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  SegmentCate;

typedef void (^SegmentedControlBlock)(SegmentCate * segmentedControl ,NSInteger selectedIndex);

typedef  NS_ENUM(NSInteger ,SegmentedControlLineStyle){
    SegmentedControlLineStyleUnder =0,
    SegmentedControlLineStyleTop =1,
    SegmentedControlLineStyleHidden =2
    
};
typedef  NS_ENUM(NSInteger ,SegmentedControlTitleSpaceStyle){
    SegmentedControlTitleSpaceStyleAutoFit =0,
    SegmentedControlTitleSpaceStyleFixed =1
};

typedef NS_ENUM(NSInteger , SegmentedControlButtonBorder){
    SegmentedControlButtonBorderHidden =0,
     SegmentedControlButtonBorderShow
};
@interface SegmentCate : UIView
- (instancetype)init;

- (instancetype)initWithFrame:(CGRect)frame;

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray <NSString *>*)titleArray;

/**
 * @property titleArray: 显示文字数组
 */
@property (nonatomic, strong) NSArray <NSString *>*titleArray;

/**
 * @property segmentedControlLineStyle: 下划线样式
 */
@property (nonatomic, assign) SegmentedControlLineStyle segmentedControlLineStyle;

/**
 * @property segmentedControlLineStyle: 按钮边框
 */

@property (nonatomic,assign)SegmentedControlButtonBorder segmentedControlBorederStyle;

/**
 * @property segmentedControlTitleSpacingStyle: 显示文字的间距样式
 */
@property (nonatomic, assign) SegmentedControlTitleSpaceStyle segmentedControlTitleSpacingStyle;
/**
 * @property lineWidthEqualToTextWidth: 下划线样式是否与当前位置的文字宽度相等
 * 如果为YES则表示下划线的宽度和文字的宽度相等, 不需要设置lineWidth 属性
 */
@property (nonatomic, assign) BOOL lineWidthEqualToTextWidth;

/**
 * @property textColor: 字体颜色
 */
@property (nonatomic, strong) UIColor *textColor;

/**
 * @property selectedTextColor: 选中位置字体颜色
 */
@property (nonatomic, strong) UIColor *selectedTextColor;

/**
 * @property font: 字体
 */
@property (nonatomic, strong) UIFont *font;

/**
 * @property selectedFont: 选中位置字体
 */
@property (nonatomic, strong) UIFont *selectedFont;

/**
 * @property lineColor: 下划线颜色
 */
@property (nonatomic, strong) UIColor *lineColor;

/**
 * @property lineHeight: 下划线高度
 */
@property (nonatomic, assign) CGFloat lineHeight;

/**
 * @property lineWidth: 下划线宽度
 */
@property (nonatomic, assign) CGFloat lineWidth;

/**
 * @property titleWidth: 文字宽度
 */
@property (nonatomic, assign) CGFloat titleWidth;

/**
 * @property titleSpacing: 文字间隔
 */
@property (nonatomic, assign) CGFloat titleSpacing;

/**
 * @property defaultSelectedIndex: 默认选中位置
 */
@property (nonatomic, assign) NSInteger defaultSelectedIndex;

/**
 * @property selectedIndex: 当前选中位置
 */
@property (nonatomic, assign, readonly) NSInteger selectedIndex;

/**
 * @property showSplitLine: 显示分割线, default is NO, if YES show splitLine
 */
@property (nonatomic, assign) BOOL showSplitLine;

/**
 * @property splitLineHeight: 分割线大小
 */
@property (nonatomic, assign) CGSize splitLineSize;

/**
 * @property splitLineColor: 分割线颜色
 */
@property (nonatomic, strong) UIColor *splitLineColor;
//滑动视图

@property (nonatomic, strong) UIScrollView *scrollView;

/** 点击回调
 *   回调
 */
- (void)segmentedControlSelectedWithBlock:(SegmentedControlBlock)block;

/** 手动设置选中位置
 * @param selectedIndex 选中位置
 */
- (void)segmentedControlSetSelectedIndex:(NSInteger)selectedIndex;

/** 手动设置选中位置且执行 segmentedControlSelectedWithBlock: 的回调方法
 * @param selectedIndex 选中位置
 *   回调
 */
- (void)segmentedControlSetSelectedIndexWithSelectedBlock:(NSInteger)selectedIndex;

@end

@interface NSString (LLAdd)

/** 计算NSString的宽度
 * @param textHeight 文字高度
 * @param text 文字
 * @param font 字体
 */
+ (float)getTextWidth:(float)textHeight text:(NSString *)text font:(UIFont *)font;

@end
