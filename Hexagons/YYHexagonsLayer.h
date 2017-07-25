//
//  YYHexagonsLayer.h
//  Hexagons
//
//  Created by 董知樾 on 2017/7/25.
//  Copyright © 2017年 董知樾. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface YYHexagonsLayer : CAShapeLayer

@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *highlightColor;

@property (nonatomic, assign, readonly) CGFloat sideLength;

@property (nonatomic, assign, getter=isSelected) BOOL selected;

+ (instancetype)layerWithSideLength:(CGFloat)sideLength;

@end
