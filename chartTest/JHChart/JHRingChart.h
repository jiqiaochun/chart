//
//  JHRingChart.h
//  JHChartDemo
//
//  Created by 简豪 on 16/7/5.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "JHChart.h"

@interface JHRingChart : JHChart

#define k_Width_Scale  (self.frame.size.width / [UIScreen mainScreen].bounds.size.width)
/*        值数组         */
@property (nonatomic,strong)NSArray * valueDataArr;


/**
 *   半径数据源 
 */
@property (nonatomic, strong) NSArray *radiusSource;

/**
 *  扇形区域背景色：数组中存放着没块区域的背景颜色
 */
@property (nonatomic, strong) NSArray *colorSource;


@end
