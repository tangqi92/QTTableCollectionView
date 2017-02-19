//
//  QTExploresCollectionViewCell.m
//  QTTableCollectionView
//
//  Created by Tang Qi on 18/02/2017.
//  Copyright © 2017 Tang. All rights reserved.
//

#import "QTExploresCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import "QTExploreModel.h"

@interface QTExploresCollectionViewCell ()

@property (nonatomic, strong) UIView *coverView;

@end

@implementation QTExploresCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)initViews {
    _coverView = [UIView new];
    _coverView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_coverView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)setExploreModel:(QTExploreModel *)exploreModel {
    
}

@end
