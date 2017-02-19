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
@interface QTTableViewController ()

@property (nonatomic, strong) NSMutableDictionary *contentOffsetDictionary;
@property (nonatomic, strong) NSMutableArray *dataSourceExplores;
@property (nonatomic, strong) NSMutableArray *dataSourceBoards;
@property (nonatomic, strong) NSMutableArray *dataSourceUsers;
@property (nonatomic, assign) BOOL shouldHideExplores;
@property (nonatomic, assign) BOOL shouldHideBoards;
@property (nonatomic, assign) BOOL shouldHideUsers;

@end

@implementation QTTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataSourceExplores = @[].mutableCopy;
    self.dataSourceBoards = @[].mutableCopy;
    self.dataSourceUsers = @[].mutableCopy;
    self.contentOffsetDictionary = [NSMutableDictionary dictionary];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[QTTableViewCell class] forCellReuseIdentifier:kCellIdentifier];

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QTTableViewCell *cell = (QTTableViewCell *) [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(QTTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        cell.collectionView.collectionViewCellType = CellTypeExplores;
    } else if (indexPath.section == 1) {
        cell.collectionView.collectionViewCellType = CellTypeBoards;
    } else if (indexPath.section == 2) {
        cell.collectionView.collectionViewCellType = CellTypeUsers;
    }

    [cell setCollectionViewDataSourceDelegate:self indexPath:indexPath];
    NSInteger index = cell.collectionView.indexPath.row;

    CGFloat horizontalOffset = [self.contentOffsetDictionary[[@(index) stringValue]] floatValue];
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
    switch (indexPath.section) {
        case 0:
            return 132;
            break;
        case 1:
            return 190;
            break;
        case 2:
            return 170;
            break;
        default:
            break;
    }
    return 0;
}

#pragma mark - UICollectionViewDataSource Methods

- (NSInteger)collectionView:(QTCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (collectionView.collectionViewCellType) {
        case CellTypeExplores:
            //            return self.dataSourceExplores.count;
            return 10;
            break;
        case CellTypeBoards:
            //            return self.dataSourceBoards.count;
            return 10;
            break;
        case CellTypeUsers:
            //            return self.dataSourceUsers.count;
            return 10;
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
            [cellExplore setup];
        }
    } else if (collectionView.collectionViewCellType == CellTypeBoards) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:BoardCollectionViewCellID forIndexPath:indexPath];
        if ([cell isKindOfClass:[QTBoardsCollectionViewCell class]]) {
            QTBoardsCollectionViewCell *cellBoard = (QTBoardsCollectionViewCell *) cell;
            [cellBoard setup];
        }
    } else if (collectionView.collectionViewCellType == CellTypeUsers) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:UserCollectionViewCellID forIndexPath:indexPath];
        if ([cell isKindOfClass:[QTUsersCollectionViewCell class]]) {
            QTUsersCollectionViewCell *cellUser = (QTUsersCollectionViewCell *) cell;
            [cellUser setup];
        }
    }
    return cell;
}

- (void)collectionView:(QTCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    if (collectionView.collectionViewCellType == CellTypeExplores) {
        //
        [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"Selected Item: %ld", index]];
    } else if (collectionView.collectionViewCellType == CellTypeBoards) {
        //
        [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"Selected Item: %ld", index]];
    } else if (collectionView.collectionViewCellType == CellTypeUsers) {
        //
        [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"Selected Item: %ld", index]];
    }
}

- (CGSize)collectionView:(QTCollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.collectionViewCellType == CellTypeExplores) {
        return CGSizeMake(132, 132);
    } else if (collectionView.collectionViewCellType == CellTypeBoards) {
        return CGSizeMake(132, 190);
    } else if (collectionView.collectionViewCellType == CellTypeUsers) {
        return CGSizeMake(132, 170);
    } else {
        return CGSizeZero;
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

- (void)refreshData {
}

@end
