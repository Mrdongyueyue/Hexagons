//
//  YYHexagonsGroupView.m
//  Hexagons
//
//  Created by 董知樾 on 2017/7/25.
//  Copyright © 2017年 董知樾. All rights reserved.
//

#import "YYHexagonsGroupView.h"
#import "YYHexagonsLayer.h"

@interface YYHexagonsGroupView ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableDictionary<NSNumber *,YYHexagonsLayer *> *hexagonsLayers;

@end

@implementation YYHexagonsGroupView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    _scrollView = [[UIScrollView alloc] init];
    [_scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
    [self addSubview:_scrollView];
}

- (void)reloadData {
    [_hexagonsLayers enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, YYHexagonsLayer * _Nonnull obj, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    [_hexagonsLayers removeAllObjects];
    
    [self createSublayers];
}

- (void)reloadIndexs:(NSArray<NSNumber *> *)indexs {
    [indexs enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_hexagonsLayers removeObjectForKey:obj];
        [_hexagonsLayers[obj] removeFromSuperlayer];
        _hexagonsLayers[obj] = [_delegate hexagonsGroupView:self hexagonsForRowAtIndex:obj.integerValue];
    }];
    
}

- (void)createSublayers {
    if (!_hexagonsLayers) {
        _hexagonsLayers = [NSMutableDictionary dictionary];
    }
    
    NSInteger MaxCount = 0;
    if ([_delegate respondsToSelector:@selector(numberOfHexagonsInGroupView:)]) {
        MaxCount = [_delegate numberOfHexagonsInGroupView:self];
    } else {
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        
        CGFloat utilWidth = _utilWidth;
        CGFloat margin = _margin;
        
        NSInteger MaxI = floor((width - (0.5 * utilWidth * 2 * sin(M_PI / 3))) / (utilWidth * 2 * sin(M_PI / 3) + margin));
        
        MaxCount = floor((height - utilWidth) / (utilWidth + cos(M_PI/3) * (utilWidth + margin))) * MaxI;
    }
    CGFloat maxY = 0;
    for (NSInteger i = 0; i < MaxCount; i ++) {
        maxY = [self addSublayerWithIndex:i];
    }
    
    _scrollView.contentSize = CGSizeMake(self.bounds.size.width, maxY + _utilWidth);
    
}

- (CGFloat)addSublayerWithIndex:(NSInteger)index {
    
    NSInteger row = 0, i = 0;
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    CGFloat utilWidth = _utilWidth;
    CGFloat margin = _margin;
    
    NSInteger MaxI = floor((width - (0.5 * utilWidth * 2 * sin(M_PI / 3))) / (utilWidth * 2 * sin(M_PI / 3) + margin));
    
    row = index / MaxI;
    i = index % MaxI;
    
    if (row * MaxI + i > [_delegate numberOfHexagonsInGroupView:self]) {
        return _scrollView.contentSize.height;
    }
    
    NSInteger MaxRow = 0;
    if ([_delegate respondsToSelector:@selector(numberOfHexagonsInGroupView:)]) {
        MaxRow = ceil([_delegate numberOfHexagonsInGroupView:self] / (double)MaxI);
    } else {
        MaxRow = floor((height - utilWidth) / (utilWidth + cos(M_PI/3) * (utilWidth + margin)));
    }
    
    
    CGFloat positionY = utilWidth * 2 + (utilWidth + cos(M_PI/3) * (utilWidth + margin)) * row;
    YYHexagonsLayer *layer = nil;
    
    if ([_delegate respondsToSelector:@selector(hexagonsGroupView:hexagonsForRowAtIndex:)]) {
        layer = [_delegate hexagonsGroupView:self hexagonsForRowAtIndex:row * MaxI + i];
    } else {
        layer = [YYHexagonsLayer layerWithSideLength:utilWidth];
        layer.normalColor = UIColor.orangeColor;
        layer.highlightColor = UIColor.cyanColor;
    }
    
    CGFloat x_offset = 0;
    if (row % 2 == 0) {
        x_offset = utilWidth * 2;
    } else {
        x_offset = utilWidth + margin * 0.5;
    }
    
    CGFloat positionX = (i + 0.5) * utilWidth * 2 * sin(M_PI / 3) + i * margin + x_offset;
    layer.position = CGPointMake(positionX, positionY);
    
    [_scrollView.layer addSublayer:layer];
    return layer.position.y;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _scrollView.frame = self.bounds;
    [self createSublayers];
}
- (void)tap:(UITapGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:_scrollView];
    [_hexagonsLayers enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, YYHexagonsLayer * _Nonnull layer, BOOL * _Nonnull stop) {
        CGPoint convertPoint = [layer convertPoint:point fromLayer:_scrollView.layer];
        if (CGPathContainsPoint(layer.path, NULL, convertPoint, NO)) {
            if ([_delegate respondsToSelector:@selector(hexagonsGroupView:didSelectRowAtIndex:)]) {
                [_delegate hexagonsGroupView:self didSelectRowAtIndex:key.integerValue];
            } else {
                layer.selected = !layer.isSelected;
            }
            *stop = YES;
        }
    }];
}

- (YYHexagonsLayer *)hexagonsLayerWithIndex:(NSInteger)index {
    YYHexagonsLayer *layer = _hexagonsLayers[@(index)];
    if (layer == nil) {
        layer = [YYHexagonsLayer layerWithSideLength:_utilWidth];
        _hexagonsLayers[@(index)] = layer;
        [self addSublayerWithIndex:index];
        NSLog(@"%ld--%ld", (long)index, _hexagonsLayers.count);
    }
    
    return layer;
}

@end
