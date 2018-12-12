//
//  TestCell.m
//  ins
//
//  Created by 方存 on 2018/11/22.
//  Copyright © 2018年 JKB. All rights reserved.
//

#import "TestCell.h"
#import "UIView+Extension.h"

@interface TestCell ()


@end


@implementation TestCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self.contentView addSubview:self.deleteBut];
    [self.contentView addSubview:self.drugNameField];
    [self.contentView addSubview:self.drugNumberField];
    [self.contentView addSubview:self.drugUseField];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.deleteBut.frame = CGRectMake(self.contentView.width - 50 - 15, 0, 50, 20);
    self.drugNameField.frame  = CGRectMake(15, 20+10, self.contentView.width - 30, 40);
    self.drugNumberField.frame  = CGRectMake(15, 20+10 + 40 + 10, self.contentView.width - 30, 40);
    self.drugUseField.frame  = CGRectMake(15, CGRectGetMaxY(self.drugNumberField.frame) + 10, self.contentView.width - 30, 40);
}

/** 删除之后的数据 */
- (void)readDataContentArr:(NSMutableArray *)contentArr index:(NSIndexPath *)index
{
    if (index.row < contentArr.count) {
        NSLog(@"------------调用cell赋值方法");
        NSDictionary *dic = contentArr[index.row];
        NSString *str1 = dic[@"medicineName"];
        NSString *str2 = dic[@"medicineSpecifications"];
        NSString *str3 = dic[@"medicineDosage"];
        self.drugNameField.text = str1;
        self.drugNumberField.text = str2;
        self.drugUseField.text = str3;        
    }
}


- (void)clickDeleteBut
{
    if (self.deleteCell_block) {
        self.deleteCell_block();
    }
}

- (void)textFieldTextChange:(UITextField *)textField
{
    if (self.textFieldChange_block) {
        self.textFieldChange_block(textField);
    }
}

#pragma mark - lazy
#pragma mark -
- (UIButton *)deleteBut
{
    if (!_deleteBut) {
        _deleteBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBut.backgroundColor = [UIColor blueColor];
        [_deleteBut setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_deleteBut addTarget:self action:@selector(clickDeleteBut) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBut;
}

- (UITextField *)drugNameField
{
    if (!_drugNameField) {
        _drugNameField = [[UITextField alloc] init];
        _drugNameField.borderStyle = UITextBorderStyleLine;
        _drugNameField.placeholder = @"药品名称";
        _drugNameField.tag = 100;
        [_drugNameField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingDidEnd];
    }
    return _drugNameField;
}

- (UITextField *)drugNumberField
{
    if (!_drugNumberField) {
        _drugNumberField = [[UITextField alloc] init];
        _drugNumberField.placeholder = @"药品规格";
        _drugNumberField.borderStyle = UITextBorderStyleLine;
        _drugNumberField.tag = 200;
        [_drugNumberField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingDidEnd];
    }
    return _drugNumberField;
}

- (UITextField *)drugUseField
{
    if (!_drugUseField) {
        _drugUseField = [[UITextField alloc] init];
        _drugUseField.placeholder = @"药品用法";
        _drugUseField.borderStyle = UITextBorderStyleLine;
        _drugUseField.tag = 300;
        [_drugUseField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingDidEnd];
    }
    return _drugUseField;
}

@end
