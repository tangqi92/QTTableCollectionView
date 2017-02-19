//
//  QTCollectionView.h
//  QTTableCollectionView
//
//  Created by Tang Qi on 18/02/2017.
//  Copyright © 2017 Tang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CollectionViewCellType) {
    CellTypeExplores = 0,
    CellTypeBoards,
    CellTypeUsers
};

@interface QTCollectionView : UICollectionView

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) CollectionViewCellType collectionViewCellType;

@end
