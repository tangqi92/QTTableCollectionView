//
//  QTTableViewController.m
//  QTTableCollectionView
//
//  Created by Tang Qi on 19/02/2017.
//  Copyright © 2017 Tang. All rights reserved.
//

#import "QTTableViewController.h"
#import "QTTableViewCell.h"
#import "QTCollectionView.h"
#import "QTExploresCollectionViewCell.h"
#import "QTBoardsCollectionViewCell.h"
#import "QTUsersCollectionViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <SVProgressHUD/SVProgressHUD.h>

static NSString *const kCellIdentifier = @"CellIdentifier";
/// 仅用于测试
static NSInteger const kNumberOfItemsInSection = 10;
@interface QTTableViewController ()

// 用于记录 CollectionView 内容的偏移量。
@property (nonatomic, strong) NSMutableDictionary *contentOffsetDictionary;
// DataSource / 数据源。
@property (nonatomic, strong) NSMutableArray *dataSourceExplores;
@property (nonatomic, strong) NSMutableArray *dataSourceBoards;
@property (nonatomic, strong) NSMutableArray *dataSourceUsers;

@end

@implementation QTTableViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 相关初始化操作
    self.dataSourceExplores = @[].mutableCopy;
    self.dataSourceBoards = @[].mutableCopy;
    self.dataSourceUsers = @[].mutableCopy;
    self.contentOffsetDictionary = [NSMutableDictionary dictionary];

    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[QTTableViewCell class] forCellReuseIdentifier:kCellIdentifier];

    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];

    self.refreshControl = [[UIRefreshControl alloc] init];
    @weakify(self);
    [[self.refreshControl rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(id x) {
        @strongify(self);
        [self refreshData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QTTableViewCell *cell = (QTTableViewCell *) [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(QTTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 为 CollectionView 设置不同的 collectionViewCellType 用以区别。
    if (indexPath.section == 0) {
        cell.collectionView.collectionViewCellType = CellTypeExplores;
    } else if (indexPath.section == 1) {
        cell.collectionView.collectionViewCellType = CellTypeBoards;
    } else if (indexPath.section == 2) {
        cell.collectionView.collectionViewCellType = CellTypeUsers;
    }

    // 设置 CollectionView 的 DataSource 与 Delegate 及所处的 indexPath。
    [cell setCollectionViewDataSourceDelegate:self indexPath:indexPath];
    NSInteger index = cell.collectionView.indexPath.row;

    CGFloat horizontalOffset = [self.contentOffsetDictionary[[@(index) stringValue]] floatValue];
    // 设置 CollectionView 的 ContentOffset。
    [cell.collectionView setContentOffset:CGPointMake(horizontalOffset, 0)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 24;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

#pragma mark - UITableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 132;
    } else if (indexPath.section == 1) {
        return 190;
    } else if (indexPath.section == 2) {
        return 170;
    }
    return 0;
}

#pragma mark - UICollectionViewDataSource Methods

- (NSInteger)collectionView:(QTCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (collectionView.collectionViewCellType) {
        case CellTypeExplores:
            return kNumberOfItemsInSection;
            // TODO: 返回真实的数据。
//            return self.dataSourceExplores.count;
            break;
        case CellTypeBoards:
            return kNumberOfItemsInSection;
//            return self.dataSourceBoards.count;
            break;
        case CellTypeUsers:
            return kNumberOfItemsInSection;
//            return self.dataSourceUsers.count;
            break;
        default:
            break;
    }
}

- (UICollectionViewCell *)collectionView:(QTCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;

    if (collectionView.collectionViewCellType == CellTypeExplores) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:ExploreCollectionViewCellID forIndexPath:indexPath];
        if ([cell isKindOfClass:[QTExploresCollectionViewCell class]]) {
            QTExploresCollectionViewCell *cellExplore = (QTExploresCollectionViewCell *) cell;
            [cellExplore setupModel];
            // TODO: 获取到相应的 Model 后进行赋值操作
//            if (self.dataSourceExplores.count > 0) {
//                cellExplore.exploreModel = self.dataSourceExplores[indexPath.row];
//            }
        }
    } else if (collectionView.collectionViewCellType == CellTypeBoards) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:BoardCollectionViewCellID forIndexPath:indexPath];
        if ([cell isKindOfClass:[QTBoardsCollectionViewCell class]]) {
            QTBoardsCollectionViewCell *cellBoard = (QTBoardsCollectionViewCell *) cell;
            [cellBoard setupModel];
//            if (self.dataSourceBoards.count > 0) {
//                cellBoard.boardModel = self.dataSourceBoards[indexPath.row];
//            }
        }
    } else if (collectionView.collectionViewCellType == CellTypeUsers) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:UserCollectionViewCellID forIndexPath:indexPath];
        if ([cell isKindOfClass:[QTUsersCollectionViewCell class]]) {
            QTUsersCollectionViewCell *cellUser = (QTUsersCollectionViewCell *) cell;
            [cellUser setupModel];
//            if (self.dataSourceUsers.count > 0) {
//                cellUser.userModel = self.dataSourceUsers[indexPath.row];
//            }
        }
    }
    return cell;
}

- (void)collectionView:(QTCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger position = indexPath.row;
    switch (collectionView.collectionViewCellType) {
        case CellTypeExplores: {
            // 获取相应的 Moddel。
//            QTExploreModel *exploreModel = self.dataSourceExplores[indexPath.row];
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"Selected CellTypeExplores Item: %ld", position]];
            break;
        }
        case CellTypeBoards: {
//            QTBoardModel *boardModel = self.dataSourceBoards[indexPath.row];
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"Selected CellTypeBoards Item: %ld", position]];
            break;
        }
        case CellTypeUsers: {
//            QTUserModel *userModel = self.dataSourceUsers[indexPath.row];
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"Selected CellTypeUsers Item: %ld", position]];
            break;
        }
        default:
            break;
    }
}

- (CGSize)collectionView:(QTCollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (collectionView.collectionViewCellType) {
        case CellTypeExplores:
            return CGSizeMake(132, 132);
            break;
        case CellTypeBoards:
            return CGSizeMake(132, 190);
            break;
        case CellTypeUsers:
            return CGSizeMake(132, 170);
            break;
        default:
            break;
    }
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (![scrollView isKindOfClass:[UICollectionView class]]) return;

    CGFloat horizontalOffset = scrollView.contentOffset.x;
    QTCollectionView *collectionView = (QTCollectionView *) scrollView;
    NSInteger index = collectionView.indexPath.row;
    self.contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffset);
}

// 该方法仅用于测试：模拟刷新操作。
- (void)refreshData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
        [SVProgressHUD showSuccessWithStatus:@"刷新成功"];
    });
}

@end
