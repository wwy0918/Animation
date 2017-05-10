//
//  WaveView.m
//  Wave
//
//  Created by wwyun on 17/5/8.
//  Copyright © 2017年 wwy. All rights reserved.
//

#import "WaveView.h"

@interface WaveView()
{
    CADisplayLink *_disPlayLink;
    
    /**
     曲线的振幅
     */
    CGFloat _waveAmplitude;
    /**
     曲线角速度
     */
    CGFloat _wavePalstance;
    /**
     曲线初相
     */
    CGFloat _waveX;
    /**
     曲线偏距
     */
    CGFloat _waveY;
    
    /**
     曲线移动速度
     */
    CGFloat _waveMoveSpeed;
}
@property (nonatomic, strong) CAShapeLayer *waveLayer;

@end

@implementation WaveView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self configData];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configData];
    }
    return self;
}

- (void)configData
{
    //振幅
    _waveAmplitude = 10;
    //角速度
    _wavePalstance = 2*M_PI / self.waveLayer.frame.size.width;
    //偏距
    _waveY = self.waveLayer.frame.size.height - _waveAmplitude*2;
    //初相
    _waveX = 0;
    //x轴移动速度
    _waveMoveSpeed = _wavePalstance * 5;
    //以屏幕刷新速度为周期刷新曲线的位置
    _disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateWave:)];
    [_disPlayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)updateWave:(CADisplayLink *)link
{
    _waveX += _waveMoveSpeed;
    self.waveLayer.path = [self wavePath].CGPath;
}

- (UIBezierPath *)wavePath
{
    UIBezierPath *wavePath = [UIBezierPath bezierPath];
    CGFloat waterWaveWidth = self.waveLayer.frame.size.width;
    [wavePath moveToPoint:CGPointMake(0, _waveY)];
    
    CGFloat y = _waveY;
    //正弦曲线公式为： y=Asin(ωx+φ)+k;
    for (float x = 0.0f; x <= waterWaveWidth ; x++) {
        y = _waveAmplitude * cos(_wavePalstance * x + _waveX) + _waveY;
        [wavePath addLineToPoint:CGPointMake(x, y)];
    }
    
    [wavePath addLineToPoint:CGPointMake(waterWaveWidth, 0)];
    [wavePath addLineToPoint:CGPointMake(0, 0)];
    [wavePath closePath];
    return wavePath;
}

- (CAShapeLayer *)waveLayer
{
    if (!_waveLayer) {
        _waveLayer = [[CAShapeLayer alloc] init];
        _waveLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        [self.layer addSublayer:_waveLayer];
    }
    return _waveLayer;
}

- (void)setBgColor:(UIColor *)bgColor
{
    _bgColor = bgColor;
    self.waveLayer.fillColor = bgColor.CGColor;
}

- (void)dealloc
{
    if (_disPlayLink) {
        [_disPlayLink invalidate];
        _disPlayLink = nil;
    }
}

@end
