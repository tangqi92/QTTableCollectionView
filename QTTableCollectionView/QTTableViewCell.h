//
//  QTTableViewCell.h
//  QTTableCollectionView
//
//  Created by Tang Qi on 18/02/2017.
//  Copyright © 2017 Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTCollectionView.h"

static NSString *const ExploreCollectionViewCellID = @"ExploreCollectionViewCellID";
static NSString *const BoardCollectionViewCellID = @"BoardCollectionViewCellID";
static NSString *const UserCollectionViewCellID = @"UserCollectionViewCellID";

@interface QTTableViewCell : UITableViewCell

@property (nonatomic, strong) QTCollectionView *collectionView;

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath;

@end
