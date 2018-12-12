//
//  TestViewController.m
//  ins
//
//  Created by 方存 on 2018/11/22.
//  Copyright © 2018年 JKB. All rights reserved.
//

#import "TestViewController.h"
#import "ViewController.h"

@interface TestViewController ()

/** <#annotation#> */
@property (nonatomic, strong) NSMutableArray *arr;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 50);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"开处方" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(but) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)but
{
//    NSMutableArray *arr = [NSMutableArray array];
//    NSDictionary *dic1 = @{@"medicineName": @"cs1", @"medicineSpecifications":@"cs1", @"medicineDosage":@"cs1"};
//    NSDictionary *dic2 = @{@"medicineName": @"cs2", @"medicineSpecifications":@"cs2", @"medicineDosage":@"cs2"};
//    NSDictionary *dic3 = @{@"medicineName": @"cs3", @"medicineSpecifications":@"cs3", @"medicineDosage":@"cs3"};
//    NSDictionary *dic4 = @{@"medicineName": @"cs4", @"medicineSpecifications":@"cs4", @"medicineDosage":@"cs4"};
//    [arr addObject:dic1];
//    [arr addObject:dic2];
//    [arr addObject:dic3];
//    [arr addObject:dic4];
//
//    NSMutableArray *dataArr = [[NSMutableArray alloc] initWithObjects:@"zwf", @"zwf", @"zwf", @"zwf", nil];
//
//    ViewController *viewVc = [[ViewController alloc] init];
//    viewVc.contentArr = arr;
//    viewVc.dataArray = dataArr;
//    viewVc.isEditor = YES;
//    [self.navigationController pushViewController:viewVc animated:YES];
    
/*************************************************************************************************/
    
    
    ViewController *viewVc = [[ViewController alloc] init];
    [self.navigationController pushViewController:viewVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
