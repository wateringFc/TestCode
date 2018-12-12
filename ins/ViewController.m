//
//  ViewController.m
//  ins
//
//  Created by 方存 on 2018/11/19.
//  Copyright © 2018年 JKB. All rights reserved.
//


#import "ViewController.h"
#import "TestCell.h"
#import "UIView+Extension.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
/** 列表 */
@property (strong, nonatomic) UITableView *tableView;
/** 头部 */
@property (nonatomic, strong) UIView *headerView;
/** 是否点击添加按钮 */
@property (nonatomic, assign) BOOL isAddBut;


/** 编辑和添加 */
@property (nonatomic, assign) BOOL isBJandTJ;

@end

@implementation ViewController

- (NSMutableArray *)contentArr
{
    if (!_contentArr) {
        _contentArr = [NSMutableArray array];
    }
    return _contentArr;
}

- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 300)];
        UIButton *addBut = [UIButton buttonWithType:UIButtonTypeCustom];
        addBut.frame = CGRectMake(self.view.bounds.size.width - 150, 240, 150, 60);
        [addBut setTitle:@"+ 添加药品" forState:UIControlStateNormal];
        [addBut setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        addBut.titleLabel.font = [UIFont systemFontOfSize:14];
        [addBut addTarget:self action:@selector(addDrugCell:) forControlEvents:UIControlEventTouchUpInside];
        [_headerView addSubview:addBut];
        
        UIButton *addBut1 = [UIButton buttonWithType:UIButtonTypeCustom];
        addBut1.frame = CGRectMake(0, 240, 150, 60);
        [addBut1 setTitle:@"保存药品" forState:UIControlStateNormal];
        [addBut1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        addBut1.titleLabel.font = [UIFont systemFontOfSize:14];
        addBut1.tag = 100;
        [addBut1 addTarget:self action:@selector(addDrugCell:) forControlEvents:UIControlEventTouchUpInside];
        [_headerView addSubview:addBut1];
        
    }
    return _headerView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasicUI];
}

- (void)setupBasicUI
{
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    self.tableView.tableHeaderView = self.headerView;
    
    // 不是编辑处方才添加默认cell
    if (!self.isEditor) {
        // 默认添加一个cell
//        TestCell *addCell = [[TestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOne"];
//        [self.dataArray addObject:addCell];
        NSString *zwfStr = @"zwf";
        [self.dataArray addObject:zwfStr];
    }
}

- (void)addDrugCell:(UIButton *)but
{
    if (but.tag == 100) {
        [self.view endEditing:YES];
        if (self.contentArr.count) {
            for (int i = 0; i < self.contentArr.count; i++) {
                NSDictionary *dic = self.contentArr[i];
                NSString *str1 = dic[@"medicineName"];
                NSString *str2 = dic[@"medicineSpecifications"];
                NSString *str3 = dic[@"medicineDosage"];
                
                NSString *string = [NSString stringWithFormat:@"%@ %@ %@",str1, str2, str3];
                NSLog(@"名= %@",string);
            }
            NSLog(@"最终== %@",self.contentArr);
        }
        return;
    }
    
    [self.view endEditing:YES];
//    cellNumBer++;
//    NSString *str = [NSString stringWithFormat:@"cellOne%ld", cellNumBer];
    self.isAddBut = YES;
    self.isSCbut = NO;
//    TestCell *addCell = [[TestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
//    [self.dataArray addObject:addCell];
    
    
    
    NSString *zwfStr = @"zwf";
    [self.dataArray addObject:zwfStr];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.dataArray.count - 1) inSection:0];
    // 添加一个cell
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    
    if (self.isEditor) {
        self.isBJandTJ = YES;
        // 滑动到最底部
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(self.dataArray.count - 1) inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:true];
    }
}


#pragma mark - UITableView Delegate/Datasource
// 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str  = [NSString stringWithFormat:@"cellId%ld",(long)indexPath.row];
    TestCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[TestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!self.isEditor) {
        if (self.contentArr.count > 0) {
            [cell readDataContentArr:self.contentArr index:indexPath];
        }
    }
    
    // 只有编辑的时候才调用
    if (self.isEditor && indexPath.row < self.contentArr.count) {
        [cell readDataContentArr:self.contentArr index:indexPath];
    }
    
    
    // 只有删除的时候才刷新cell数据
    if (self.contentArr.count > 0) {
        if (self.isSCbut) {
            [cell readDataContentArr:self.contentArr index:indexPath];
        }
    }
    
    // 如果是添加的cell，清空之前的填写数据
    if ((self.isAddBut && (indexPath.row == (self.dataArray.count-1))) || (self.isAddBut && (indexPath.row == (self.dataArray.count-1)) && self.isBJandTJ)) {
        cell.drugNameField.text = @"";
        cell.drugNumberField.text = @"";
        cell.drugUseField.text = @"";
    }
    

    
    // 删除cell
    [cell setDeleteCell_block:^{
        [self.view endEditing:YES];
        // 添加设置为NO
        self.isAddBut = NO;
        // 编辑添加为NO
        self.isBJandTJ = NO;
        if (indexPath.row < self.contentArr.count) {
            // 删除当前已添加数据
            [self.contentArr removeObjectAtIndex:indexPath.row];
        }
        // 删除当前cell数据源
        [self.dataArray removeObjectAtIndex:indexPath.row];
        
        // 删除cell
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView endUpdates];
        
        // 当一次添加了很多cell，但只使用到了其中部分cell，当删除其它空白cell时，保证不刷新cell数据，引起数组越界奔溃错误
        if (indexPath.row <= self.contentArr.count) {
            self.isSCbut = YES;  // 遗留问题，当添加完成，删除最后一个的时候，数据不对，待解决  11-22
        }
        // 刷新数据
        [self.tableView reloadData];
    }];
    
    /*  《编辑》——————————
     1、修改  +
     2、删除  +
     3、添加  +
     4、修改、添加 +
     5、删除，修改 +
     6、删除、添加 +
     7、删除、添加、添加 +
     8、什么都不做 +
     */
    
    /* 《添加》——————————
     1、添加 +
     2、修改 +
     3、删除已有中间 +
     3、删除已有最后一个   ？ 有问题待解决   11-22
     4、删除空白 +
     */
    
    // cell编辑
    __block NSString *str1 = @"";
    __block NSString *str2 = @"";
    __block NSString *str3 = @"";
    __weak typeof(self) weakSelf = self;
    [cell setTextFieldChange_block:^(UITextField *textField) {
        
        if (self.isEditor && indexPath.row < self.contentArr.count) {
            NSDictionary *dic = self.contentArr[indexPath.row];
            str1 = dic[@"medicineName"];
            str2 = dic[@"medicineSpecifications"];
            str3 = dic[@"medicineDosage"];
        }
        
        switch (textField.tag) {
            case 100:
                str1 = textField.text;
                break;
                
            case 200:
                str2 = textField.text;
                break;
                
            case 300:
                str3 = textField.text;
                break;
                
            default:
                break;
        }
        if (str1.length > 0 && str2.length > 0 && str3.length > 0) {
            
            // 如果是编辑进来 且 3个值已经填写，那么就设置 编辑添加 为否，不去触发清空内容操作，(当是直接添加则需要清空内容)
            if (self.isEditor && indexPath.row == self.dataArray.count-1) {
                self.isBJandTJ = NO;
            }

            
            NSDictionary *dic = @{@"medicineName": str1, @"medicineSpecifications":str2, @"medicineDosage":str3};
            if (indexPath.row < weakSelf.contentArr.count) {
                // 修改对应cell数据
                [weakSelf.contentArr replaceObjectAtIndex:indexPath.row withObject:dic];
                return;
            }
            [weakSelf.contentArr addObject:dic];
        }        
    }];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    self.isAddBut = NO;
    
    // 如果是编辑push进来点击的添加药品
    if (self.isEditor && self.isBJandTJ) {
        self.isAddBut = YES;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end









/*************************************************************************************************/



//#import "ViewController.h"
//#import "AddDrugCell.h"
//#import "UIView+Extension.h"
//
//static NSString *const addDrugCellID = @"addDrugCellID";
//@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
///** 列表 */
//@property (strong, nonatomic) UITableView *tableView;
///**  */
//@property (nonatomic, strong) NSMutableArray *dataArray;
//@property (nonatomic, strong) UIView *headerView;
///**  */
//@property (nonatomic, strong) NSMutableArray *contentArr;
///** 是否点击添加按钮 */
//@property (nonatomic, assign) BOOL isAddBut;
//@end
//
//@implementation ViewController
//
//- (NSMutableArray *)contentArr
//{
//    if (!_contentArr) {
//        _contentArr = [NSMutableArray array];
//    }
//    return _contentArr;
//}
//
//- (UIView *)headerView
//{
//    if (!_headerView) {
//        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
//        UIButton *addBut = [UIButton buttonWithType:UIButtonTypeCustom];
//        addBut.frame = CGRectMake(self.view.bounds.size.width - 150, 0, 150, 60);
//        [addBut setTitle:@"+ 添加药品" forState:UIControlStateNormal];
//        [addBut setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//        addBut.titleLabel.font = [UIFont systemFontOfSize:14];
//        [addBut addTarget:self action:@selector(addDrugCell:) forControlEvents:UIControlEventTouchUpInside];
//        [_headerView addSubview:addBut];
//
//        UIButton *addBut1 = [UIButton buttonWithType:UIButtonTypeCustom];
//        addBut1.frame = CGRectMake(0, 0, 150, 60);
//        [addBut1 setTitle:@"保存药品" forState:UIControlStateNormal];
//        [addBut1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//        addBut1.titleLabel.font = [UIFont systemFontOfSize:14];
//        addBut1.tag = 100;
//        [addBut1 addTarget:self action:@selector(addDrugCell:) forControlEvents:UIControlEventTouchUpInside];
//        [_headerView addSubview:addBut1];
//
//    }
//    return _headerView;
//}
//
//- (NSMutableArray *)dataArray
//{
//    if (!_dataArray) {
//        _dataArray = [NSMutableArray array];
//    }
//    return _dataArray;
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    [self setupBasicUI];
//}
//
//- (void)setupBasicUI
//{
//    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
//        [self setEdgesForExtendedLayout:UIRectEdgeNone];
//    }
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
//    _tableView.backgroundColor = [UIColor whiteColor];
//    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:_tableView];
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AddDrugCell class]) bundle:nil] forCellReuseIdentifier:addDrugCellID];
//    self.tableView.tableHeaderView = self.headerView;
//
//    // 默认添加一个cell
//    AddDrugCell *addCell = [AddDrugCell viewFromNib];
//    self.isAddBut = YES;
//    [self.dataArray addObject:addCell];
//}
//
//- (void)addDrugCell:(UIButton *)but
//{
//    if (but.tag == 100) {
//        if (self.contentArr.count) {
//            for (int i = 0; i < self.contentArr.count; i++) {
//                NSDictionary *dic = self.contentArr[i];
//                NSString *str1 = dic[@"medicineName"];
//                NSString *str2 = dic[@"medicineSpecifications"];
//                NSString *str3 = dic[@"medicineDosage"];
//
//                NSString *string = [NSString stringWithFormat:@"%@ %@ %@",str1, str2, str3];
//                NSLog(@"名= %@",string);
//            }
//        }
//        return;
//    }
//
//    AddDrugCell *addCell = [AddDrugCell viewFromNib];
//    self.isAddBut = YES;
//    [self.dataArray addObject:addCell];
//
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.dataArray.count - 1) inSection:0];
//    // 添加一个cell
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
//
////    // 滑动到最底部
////    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(self.dataArray.count - 1) inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:true];
//}
//
//- (void)clickDrugCellDeleteBut:(UIButton *)but
//{
//    NSLog(@"删除");
//}
//
//
//#pragma mark - UITableView Delegate/Datasource
//// 高度
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 136;
//}
//
//// 行数
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return self.dataArray.count;
//}
//
//
//// cell
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    AddDrugCell *cell = [tableView dequeueReusableCellWithIdentifier:addDrugCellID];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//    if (self.isAddBut && (indexPath.row == (self.dataArray.count-1))) {
//        NSLog(@"添加cell复用 == %@%@%@", cell.drugNameField.text, cell.drugNumberField.text, cell.drugUseField.text);
//        cell.drugNameField.text = @"";
//        cell.drugNumberField.text = @"";
//        cell.drugUseField.text = @"";
//    }
//
//    // 删除cell
//    [cell setDeleteCell_block:^{
//        self.isAddBut = NO;
//        if (indexPath.row < self.contentArr.count) {
//            NSLog(@"-------------------调用了删除数据源中第 %ld 个", indexPath.row);
//            [self.contentArr removeObjectAtIndex:indexPath.row];
//        }
//        [self.dataArray removeObjectAtIndex:indexPath.row];
//        [self.tableView beginUpdates];
//        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
//        [self.tableView endUpdates];
//
//
//        NSLog(@"self.contentArr = %@",self.contentArr);
//        [cell readDataContentArr:self.contentArr index:indexPath];
//        [self.tableView reloadData];
//    }];
//
//
//    // cell编辑
//    __block NSString *str1 = @"";
//    __block NSString *str2 = @"";
//    __block NSString *str3 = @"";
//    __weak typeof(self) weakSelf = self;
//    [cell setTextFieldChange_block:^(UITextField *textField, NSInteger fieldTag) {
//        self.isAddBut = NO;
//        switch (fieldTag) {
//            case 11:
//            {
//                str1 = textField.text;
//            }
//                break;
//            case 12:
//            {
//                str2 = textField.text;
//            }
//                break;
//            case 13:
//            {
//                str3 = textField.text;
//            }
//                break;
//
//            default:
//                break;
//        }
//        if (str1.length > 0 && str2.length > 0 && str3.length > 0) {
//            NSDictionary *dic = @{@"medicineName": str1, @"medicineSpecifications":str2, @"medicineDosage":str3};
//            if (indexPath.row < weakSelf.contentArr.count) {
//                // 不应该是删除，应该是修改
//                [weakSelf.contentArr replaceObjectAtIndex:indexPath.row withObject:dic];
//                return;
//            }
//            [weakSelf.contentArr addObject:dic];
//        }
//
//
//    }];
//
//    return cell;
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    [self.view endEditing:YES];
//}
//
//
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//@end
