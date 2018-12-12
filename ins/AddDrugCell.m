//
//  AddDrugCell.m
//  ins
//
//  Created by 方存 on 2018/11/19.
//  Copyright © 2018年 JKB. All rights reserved.
//

#import "AddDrugCell.h"

@interface AddDrugCell ()


@end

@implementation AddDrugCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

/** 删除之后的数据 */
- (void)readDataContentArr:(NSMutableArray *)contentArr index:(NSIndexPath *)index
{
    if (contentArr.count > 0) {
        NSDictionary *dic = contentArr[index.row];
        NSString *str1 = dic[@"medicineName"];
        NSString *str2 = dic[@"medicineSpecifications"];
        NSString *str3 = dic[@"medicineDosage"];
        self.drugNameField.text = str1;
        self.drugNumberField.text = str2;
        self.drugUseField.text = str3;
        NSLog(@"------------调用cell赋值方法");
    }
}


- (IBAction)deleteDrugBut:(UIButton *)sender
{
    if (self.deleteCell_block) {
        self.deleteCell_block();
    }
}

- (IBAction)textFieldTextChange:(UITextField *)sender
{
    if (self.textFieldChange_block) {
        self.textFieldChange_block(sender ,sender.tag);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
