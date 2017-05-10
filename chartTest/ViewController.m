//
//  ViewController.m
//  chartTest
//
//  Created by 姬巧春 on 16/7/15.
//  Copyright © 2016年 姬巧春. All rights reserved.
//

#import "ViewController.h"
#import "JHRingChart.h"

#define k_MainBoundsWidth [UIScreen mainScreen].bounds.size.width
#define k_MainBoundsHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 50, 100, 50)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)btnClick:(UIButton *)btn{
    [self showRingChartView];
}

//环状图
- (void)showRingChartView{
    
    JHRingChart *ring = [[JHRingChart alloc] initWithFrame:CGRectMake(0, 200, k_MainBoundsWidth, k_MainBoundsWidth)];
    ring.backgroundColor = [UIColor blackColor];
    ring.valueDataArr = @[@"0.3",@"0.3",@"0.4"];
    ring.radiusSource = @[@(85),@(95),@(105)];
    ring.colorSource = @[[UIColor redColor], [UIColor blueColor],[UIColor grayColor]];
    [ring showAnimation];
    [self.view addSubview:ring];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
