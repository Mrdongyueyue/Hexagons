//
//  YYHexagonsLayer.m
//  Hexagons
//
//  Created by 董知樾 on 2017/7/25.
//  Copyright © 2017年 董知樾. All rights reserved.
//

#import "YYHexagonsLayer.h"

@implementation YYHexagonsLayer

+ (instancetype)layerWithSideLength:(CGFloat)sideLength {
    YYHexagonsLayer *layer = [YYHexagonsLayer layer];
    
    CGFloat utilAngle = M_PI / 3;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(cos(utilAngle * 0.5) * sideLength, sin(utilAngle * 0.5) * sideLength)];
    
    [path addLineToPoint:CGPointMake(cos(utilAngle * 1.5) * sideLength, sin(utilAngle * 1.5) * sideLength)];
    [path addLineToPoint:CGPointMake(cos(utilAngle * 2.5) * sideLength, sin(utilAngle * 2.5) * sideLength)];
    [path addLineToPoint:CGPointMake(cos(utilAngle * 3.5) * sideLength, sin(utilAngle * 3.5) * sideLength)];
    [path addLineToPoint:CGPointMake(cos(utilAngle * 4.5) * sideLength, sin(utilAngle * 4.5) * sideLength)];
    [path addLineToPoint:CGPointMake(cos(utilAngle * 5.5) * sideLength, sin(utilAngle * 5.5) * sideLength)];
    
    layer.path = path.CGPath;
    layer.fillColor = UIColor.orangeColor.CGColor;
    layer.bounds = CGRectMake(0, 0, sideLength * 2, sin(utilAngle * 1) * sideLength * 2);
    
    layer->_sideLength = sideLength;
    
    return layer;
}

- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    [self resetFillColor];
}

- (void)setHighlightColor:(UIColor *)highlightColor {
    _highlightColor = highlightColor;
    [self resetFillColor];
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    [self resetFillColor];
}

- (void)resetFillColor {
    if (_selected) {
        self.fillColor = _highlightColor.CGColor;
    } else {
        self.fillColor = _normalColor.CGColor;
    }
}

@end
