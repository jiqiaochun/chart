//
//  JHRingChart.m
//  JHChartDemo
//
//  Created by 简豪 on 16/7/5.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "JHRingChart.h"
#define k_COLOR_STOCK @[[UIColor colorWithRed:1.000 green:0.783 blue:0.371 alpha:1.000], [UIColor colorWithRed:1.000 green:0.562 blue:0.968 alpha:1.000],[UIColor colorWithRed:0.313 green:1.000 blue:0.983 alpha:1.000],[UIColor colorWithRed:0.560 green:1.000 blue:0.276 alpha:1.000],[UIColor colorWithRed:0.239 green:0.651 blue:0.170 alpha:1.000]]

@interface JHRingChart ()

//环图间隔 单位为π
@property (nonatomic,assign)CGFloat itemsSpace;

//数值和
@property (nonatomic,assign) CGFloat totolCount;

@property (nonatomic,assign) CGFloat redius;

@end


@implementation JHRingChart

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.chartOrigin = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame)/2);
//        _redius = (CGRectGetHeight(self.frame) -60*k_Width_Scale)/4;
//        self.radiusSource = @[@((CGRectGetHeight(self.frame) -150*k_Width_Scale)/4),@((CGRectGetHeight(self.frame) -120*k_Width_Scale)/4),@((CGRectGetHeight(self.frame) -90*k_Width_Scale)/4),@((CGRectGetHeight(self.frame) -60*k_Width_Scale)/4),@((CGRectGetHeight(self.frame) -30*k_Width_Scale)/4)];
    }
    return self;
}



-(void)setValueDataArr:(NSArray *)valueDataArr{
    
    
    _valueDataArr = valueDataArr;
    
    [self configBaseData];
    
}

- (void)configBaseData{
    
    _totolCount = 0;
//    _itemsSpace =  (M_PI * 2.0 * 10 / 360)/_valueDataArr.count ;
    _itemsSpace = 0;
    for (id obj in _valueDataArr) {
        
        _totolCount += [obj floatValue];
        
    }

}

//开始动画
- (void)showAnimation{
    
    /*        动画开始前，应当移除之前的layer         */
    for (CALayer *layer in self.layer.sublayers) {
        [layer removeFromSuperlayer];
    }
    
    
    CGFloat lastBegin = -M_PI/2;
    
    CGFloat totloL = 0;
    NSInteger  i = 0;
    for (id obj in _valueDataArr) {
        
        CAShapeLayer *layer = [CAShapeLayer layer] ;

//        UIBezierPath *path = [UIBezierPath bezierPath];

        CGFloat cuttentpace = [obj floatValue] / _totolCount * (M_PI * 2 - _itemsSpace * _valueDataArr.count);
        totloL += [obj floatValue] / _totolCount;

        _redius = [self.radiusSource[i] floatValue];
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.chartOrigin radius:_redius startAngle:lastBegin endAngle:lastBegin + cuttentpace clockwise:YES];
        [path addLineToPoint:self.chartOrigin];
        
        [path closePath];
        
//        [path addArcWithCenter:self.chartOrigin radius:_redius startAngle:lastBegin  endAngle:lastBegin  + cuttentpace clockwise:YES];
        
        layer.lineWidth = 1*k_Width_Scale;
        layer.fillColor = [self.colorSource[i] CGColor];
//        layer.strokeColor = [self.colorSource[i] CGColor];
        layer.path = path.CGPath;
        [self.layer addSublayer:layer];
        
        
        
//        CALayer *gradinetLayer = [CALayer layer];
//        CAGradientLayer *gradient1 = [CAGradientLayer layer];
//        gradient1.frame = CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height);
//        [gradient1 setColors:[NSArray arrayWithObjects:(id)[[UIColor redColor] CGColor],(id)[[UIColor yellowColor] CGColor], nil]];
//        [gradient1 setLocations:@[@0.5,@0.9,@1]];
//        [gradient1 setStartPoint :CGPointMake (0.5,1)];
//        [gradient1 setEndPoint: CGPointMake(0.5,0)];
//        [gradinetLayer addSublayer:gradient1];
//        
//        CAGradientLayer  * gradLayer2 = [CAGradientLayer   layer];
//        gradLayer2. frame =  CGRectMake(self.frame.size.width/ 2,0,self.frame.size. width/ 2, self.frame.size.height);
//        [gradLayer2 setColors :[ NSArray  arrayWithObjects :(id)[ [UIColor yellowColor] CGColor ],(id)[[ UIColor  blueColor ] CGColor ],nil]];
//        [gradLayer2 setStartPoint :CGPointMake (0.5,0)];
//        [gradLayer2 setEndPoint: CGPointMake(0.5,1)];
//        [gradinetLayer addSublayer:gradLayer2];
//        [gradinetLayer setMask:layer];
//        [self.layer  addSublayer:gradinetLayer];
        
        
        CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        basic.fromValue = @(0);
        basic.toValue = @(1);
        basic.duration = 0.5;
        basic.fillMode = kCAFillModeForwards;
        
        [layer addAnimation:basic forKey:@"basic"];
        lastBegin += (cuttentpace+_itemsSpace);
        i++;
    }
}


-(void)drawRect:(CGRect)rect{
    CGContextRef contex = UIGraphicsGetCurrentContext();
    
    CGFloat lastBegin = 0;
    CGFloat longLen = _redius +30*k_Width_Scale;
    for (NSInteger i = 0; i<_valueDataArr.count; i++) {
        _redius = [self.radiusSource[i] floatValue];
        longLen = _redius +30*k_Width_Scale;
        
        id obj = _valueDataArr[i];
        CGFloat currentSpace = [obj floatValue] / _totolCount * (M_PI * 2 - _itemsSpace * _valueDataArr.count);;
        NSLog(@"%f",currentSpace);
        CGFloat midSpace = lastBegin + currentSpace / 2;
        
        CGPoint begin = CGPointMake(self.chartOrigin.x + sin(midSpace) * _redius, self.chartOrigin.y - cos(midSpace)*_redius);
        CGPoint endx = CGPointMake(self.chartOrigin.x + sin(midSpace) * longLen, self.chartOrigin.y - cos(midSpace)*longLen);
        
        NSLog(@"%@%@",NSStringFromCGPoint(begin),NSStringFromCGPoint(endx));
        lastBegin += _itemsSpace + currentSpace;
        
        [self drawLineWithContext:contex andStarPoint:begin andEndPoint:endx andIsDottedLine:NO andColor:self.colorSource[i]];
        CGPoint secondP = CGPointZero;
        
        CGSize size = [[NSString stringWithFormat:@"%.0f%c",[obj floatValue] / _totolCount * 100,'%'] boundingRectWithSize:CGSizeMake(200, 100) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10*k_Width_Scale]} context:nil].size;
        
        if (midSpace<M_PI) {
            secondP =CGPointMake(endx.x + 20*k_Width_Scale, endx.y);
          [self drawText:[NSString stringWithFormat:@"%.0f%c",[obj floatValue] / _totolCount * 100,'%'] andContext:contex atPoint:CGPointMake(secondP.x + 3, secondP.y - size.height / 2) WithColor:self.colorSource[i] andFontSize:10*k_Width_Scale];

        }else{
             secondP =CGPointMake(endx.x - 20*k_Width_Scale, endx.y);
            [self drawText:[NSString stringWithFormat:@"%.0f%c",[obj floatValue] / _totolCount * 100,'%'] andContext:contex atPoint:CGPointMake(secondP.x - size.width - 3, secondP.y - size.height/2) WithColor:self.colorSource[i] andFontSize:10*k_Width_Scale];
        }
          [self drawLineWithContext:contex andStarPoint:endx andEndPoint:secondP andIsDottedLine:NO andColor:self.colorSource[i]];
//        [self drawPointWithRedius:3 andColor:self.colorSource[i] andPoint:secondP andContext:contex];
       
    }
}



@end
