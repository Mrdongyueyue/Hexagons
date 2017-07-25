//
//  YYHexagonsGroupView.h
//  Hexagons
//
//  Created by 董知樾 on 2017/7/25.
//  Copyright © 2017年 董知樾. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYHexagonsGroupView, YYHexagonsLayer;
@protocol YYHexagonsGroupViewDelegate <NSObject>

@required
- (NSInteger)numberOfHexagonsInGroupView:(YYHexagonsGroupView *)hexagonsGroupView;
- (YYHexagonsLayer *)hexagonsGroupView:(YYHexagonsGroupView *)hexagonsGroupView hexagonsForRowAtIndex:(NSInteger)index;

@optional
- (void)hexagonsGroupView:(YYHexagonsGroupView *)hexagonsGroupView didSelectRowAtIndex:(NSInteger)index;

@end


@interface YYHexagonsGroupView : UIView

@property (nonatomic, weak) id<YYHexagonsGroupViewDelegate> delegate;
@property (nonatomic, assign) CGFloat utilWidth;
@property (nonatomic, assign) CGFloat margin;

- (void)reloadData;
- (void)reloadIndexs:(NSArray<NSNumber *> *)indexs;

- (YYHexagonsLayer *)hexagonsLayerWithIndex:(NSInteger)index;

@end
