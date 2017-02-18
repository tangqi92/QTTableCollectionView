//
//  QTExploresCollectionViewCell.m
//  QTTableCollectionView
//
//  Created by Tang Qi on 18/02/2017.
//  Copyright © 2017 Tang. All rights reserved.
//

#import "QTExploresCollectionViewCell.h"
#import <Masonry/Masonry.h>

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
    [self.contentView addSubview:_coverView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)setExplore:(HBExplore *)explore {
    _explore = explore;
    HBCover *cover = explore.cover;
    [self.coverImageView sd_setImageWithURL:[cover squareCoverURL]];
    NSMutableAttributedString *attrAext = [[NSMutableAttributedString alloc] initWithString:explore.name];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.firstLineHeadIndent = 10;
    [attrAext addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attrAext.length)];
    self.titleLabel.attributedText = attrAext;
    self.titleLabel.backgroundColor = [UIColor colorFromHexRGB:[NSString stringWithFormat:@"#%@", explore.theme] alpha:0.92f];
}

@end
