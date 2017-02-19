//
//  QTTableViewCell.m
//  QTTableCollectionView
//
//  Created by Tang Qi on 18/02/2017.
//  Copyright © 2017 Tang. All rights reserved.
//

#import "QTTableViewCell.h"
#import "QTExploresCollectionViewCell.h"
#import "QTBoardsCollectionViewCell.h"
#import "QTUsersCollectionViewCell.h"
#import <Masonry/Masonry.h>

@implementation QTTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[QTCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    // Cell Explore
    [self.collectionView registerClass:[QTExploresCollectionViewCell class] forCellWithReuseIdentifier:ExploreCollectionViewCellID];
    // Cell Board
    [self.collectionView registerClass:[QTBoardsCollectionViewCell class] forCellWithReuseIdentifier:BoardCollectionViewCellID];
    // Cell User
    [self.collectionView registerClass:[QTUsersCollectionViewCell class] forCellWithReuseIdentifier:UserCollectionViewCellID];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.collectionView];
    self.backgroundColor= [UIColor whiteColor];

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath {
    self.collectionView.dataSource = dataSourceDelegate;
    self.collectionView.delegate = dataSourceDelegate;
    self.collectionView.indexPath = indexPath;
    [self.collectionView setContentOffset:self.collectionView.contentOffset animated:NO];
    [self.collectionView reloadData];
}

@end
