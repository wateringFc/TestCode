//
//  UIView+Extension.h
//  HealthManagement
//
//  Created by 方存 on 2017/3/22.
//  Copyright © 2017年 健康宝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
/** 判断一个控件是否真正显示在window上 */
- (BOOL)isShowingKeyWindow;
/** 加载Nib */
+ (instancetype)viewFromNib;
/** 添加手势 */
- (void)addTarget:(id)target action:(SEL)action;
@end
