//
//  MyViewController.m
//  AYLabelCloud
//
//  Created by Andy on 2017/3/9.
//  Copyright © 2017年 wangyawei. All rights reserved.
//

#import "MyViewController.h"
#import "AutoNumberLabelView.h"

#define kScreenW  [UIScreen mainScreen].bounds.size.width
#define kScreenH  [UIScreen mainScreen].bounds.size.height


@interface MyViewController ()<AutoNumberLabelViewDelegate>

@property(nonatomic,strong)NSArray *dataArr;

@end

@implementation MyViewController

/**
 *shu
 */
-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = @[@{@"one":@"测试123"},@{@"two":@"测试2"},@{@"three":@"测试3"},@{@"one":@"测试1"},@{@"two":@"测试2"},@{@"three":@"测试3ff"},@{@"one":@"测试1"},@{@"two":@"测试277"},@{@"three":@"测试3000"},@{@"one":@"测试1"},@{@"two":@"测试2"},@{@"three":@"测试399"},@{@"three":@"测试3000"},@{@"one":@"测试123234"},@{@"two":@"测试256"},@{@"three":@"测试399"},@{@"three":@"测试3000"},@{@"one":@"测试1"},@{@"two":@"测试2"},@{@"three":@"测试399"}];
    }
    return _dataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
  
    AutoNumberLabelView * autoView = [[AutoNumberLabelView alloc]initWithFrame:CGRectMake(0, 100, kScreenW, 0) Buttons:self.dataArr FontSize:15];
    autoView.frame = CGRectMake(0, 100, kScreenW, autoView.hight);
    autoView.backgroundColor = [UIColor yellowColor];
    autoView.delegate = self;
    [self.view addSubview:autoView];
 
}


//  AutoNumberLabelViewDelegate
-(void)autoNumberLabelView:(AutoNumberLabelView *)autoNumberLabelView didSelectLabelAtIndex:(NSInteger)index{
    NSLog(@"did clicked index is %ld", index);
}




@end
