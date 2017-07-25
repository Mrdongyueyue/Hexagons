//
//  ViewController.m
//  Hexagons
//
//  Created by 董知樾 on 2017/7/25.
//  Copyright © 2017年 董知樾. All rights reserved.
//

#import "ViewController.h"
#import "YYHexagonsLayer.h"
#import "YYHexagonsGroupView.h"

@interface ViewController ()<YYHexagonsGroupViewDelegate>

@property (nonatomic, strong) YYHexagonsGroupView *groupView;

@property (nonatomic, assign) NSInteger count;

@end

@implementation ViewController {
    BOOL _selected[1000];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _groupView = [[YYHexagonsGroupView alloc] initWithFrame:CGRectMake(10, 30, self.view.bounds.size.width - 20, 400)];
    
    _groupView.utilWidth = 15;
    _groupView.margin = 2;
    _groupView.delegate = self;
    _groupView.layer.borderWidth = 1;
    _groupView.layer.borderColor = [UIColor colorWithRed:0.3 green:0.8 blue:1 alpha:1].CGColor;
    
    [self.view addSubview:_groupView];
    
    _count = 150;
    for (NSInteger i = 0; i < _count; i ++) {
        _selected[i] = NO;
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:button];
    button.contentEdgeInsets = UIEdgeInsetsMake(3, 10, 3, 10);
    NSArray *constraint = @[
                            [button.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-10],
                            [button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                            ];
    [NSLayoutConstraint activateConstraints:constraint];
    button.backgroundColor = [UIColor colorWithRed:0.3 green:0.8 blue:1 alpha:1];
    [button setTitle:@"add count" forState:UIControlStateNormal];
    button.layer.cornerRadius = 3;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(addHexagonsCount:) forControlEvents:UIControlEventTouchUpInside];
}

//MARK:~~~~ YYHexagonsGroupViewDelegate ~~~~
- (NSInteger)numberOfHexagonsInGroupView:(YYHexagonsGroupView *)hexagonsGroupView {
    return _count;
}
- (YYHexagonsLayer *)hexagonsGroupView:(YYHexagonsGroupView *)hexagonsGroupView hexagonsForRowAtIndex:(NSInteger)index {
    YYHexagonsLayer *layer = [hexagonsGroupView hexagonsLayerWithIndex:index];
    layer.highlightColor = UIColor.cyanColor;
    layer.normalColor = UIColor.orangeColor;
    layer.selected = _selected[index];
    
    return layer;
}

- (void)hexagonsGroupView:(YYHexagonsGroupView *)hexagonsGroupView didSelectRowAtIndex:(NSInteger)index {
    _selected[index] = !_selected[index];
    [hexagonsGroupView reloadIndexs:@[@(index)]];
}

- (void)addHexagonsCount:(UIButton *)button {
    _count += 20;
    [_groupView reloadData];
}

@end
