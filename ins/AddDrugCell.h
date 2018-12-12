//
//  AddDrugCell.h
//  ins
//
//  Created by 方存 on 2018/11/19.
//  Copyright © 2018年 JKB. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol AddDrugCellDelegate <NSObject>
//
//- (void)clickDrugCellDeleteBut:(UIButton *)but;
//
//@end

typedef void(^DeleteCell_Block)(void);
typedef void(^TextFieldChange_Block)(UITextField *textField, NSInteger fieldTag);

@interface AddDrugCell : UITableViewCell
/** 药品名称 */
@property (weak, nonatomic) IBOutlet UITextField *drugNameField;
/** 药品规格 */
@property (weak, nonatomic) IBOutlet UITextField *drugNumberField;
/** 药品用法 */
@property (weak, nonatomic) IBOutlet UITextField *drugUseField;
/** 药品cell代理 */
//@property (nonatomic, weak) id<AddDrugCellDelegate> delegate;


@property (nonatomic, copy) DeleteCell_Block deleteCell_block;
@property (nonatomic, copy) TextFieldChange_Block textFieldChange_block;

/** 删除之后的数据 */
- (void)readDataContentArr:(NSMutableArray *)contentArr index:(NSIndexPath *)index;

@end
