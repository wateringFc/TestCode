//
//  ViewController.h
//  ins
//
//  Created by 方存 on 2018/11/19.
//  Copyright © 2018年 JKB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

/**  */
@property (nonatomic, strong) NSMutableArray *dataArray;
/**  */
@property (nonatomic, strong) NSMutableArray *contentArr;
/** 是否点击了删除按钮 */
@property (nonatomic, assign) BOOL isSCbut;
/** 是否是编辑处方 */
@property (nonatomic, assign) BOOL isEditor;

@end

