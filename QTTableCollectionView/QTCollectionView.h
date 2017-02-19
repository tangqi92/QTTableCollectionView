//
//  QTCollectionView.h
//  QTTableCollectionView
//
//  Created by Tang Qi on 18/02/2017.
//  Copyright © 2017 Tang. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 三种类型的 Cell。
typedef NS_ENUM(NSInteger, CollectionViewCellType) {
    CellTypeExplores = 0,
    CellTypeBoards,
    CellTypeUsers
};

@interface QTCollectionView : UICollectionView

/// indexPath 用于查询相应的 Model，并填充至 Cell。
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) CollectionViewCellType collectionViewCellType;

@end
