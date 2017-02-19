//
//  QTBoardsCollectionViewCell.h
//  QTTableCollectionView
//
//  Created by Tang Qi on 18/02/2017.
//  Copyright © 2017 Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTBoardModel.h"

@interface QTBoardsCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) QTBoardModel *boardModel;
/// 该方仅法用于测试。
- (void)setupModel;

@end
