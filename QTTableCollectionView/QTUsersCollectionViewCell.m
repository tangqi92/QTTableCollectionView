//
//  QTUsersCollectionViewCell.m
//  QTTableCollectionView
//
//  Created by Tang Qi on 18/02/2017.
//  Copyright © 2017 Tang. All rights reserved.
//

#import "QTUsersCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import "QTExploreModel.h"

@interface QTUsersCollectionViewCell ()

// TODO: 请根据自身需求，自定义 CollectionViewCell。
@property (nonatomic, strong) UIView *coverView;

@end

@implementation QTUsersCollectionViewCell

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
    [self.contentView addSubview:_coverView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)setUserModel:(QTUserModel *)userModel {
    // TODO: 数据填充
}

- (void)setupModel {
    self.coverView.backgroundColor = [UIColor blueColor];
}

@end
