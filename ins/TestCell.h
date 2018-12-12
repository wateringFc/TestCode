//
//  TestCell.h
//  ins
//
//  Created by 方存 on 2018/11/22.
//  Copyright © 2018年 JKB. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^DeleteCell_Block)(void);
typedef void(^TextFieldChange_Block)(UITextField *textField);

@interface TestCell : UITableViewCell


/** 删除按钮 */
@property (nonatomic, strong) UIButton *deleteBut;
/** 药品名称 */
@property (strong, nonatomic)  UITextField *drugNameField;
/** 药品规格 */
@property (strong, nonatomic)  UITextField *drugNumberField;
/** 药品用法 */
@property (strong, nonatomic)  UITextField *drugUseField;

@property (nonatomic, copy) DeleteCell_Block deleteCell_block;
@property (nonatomic, copy) TextFieldChange_Block textFieldChange_block;

/** 删除之后的数据 */
- (void)readDataContentArr:(NSMutableArray *)contentArr index:(NSIndexPath *)index;

@end
