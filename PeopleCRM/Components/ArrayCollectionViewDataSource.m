//
//  ArrayCollectionViewDataSource.m
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/10/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import "ArrayCollectionViewDataSource.h"

@interface ArrayCollectionViewDataSource ()

@property (nonatomic, copy) NSString *nibFile;
@property (nonatomic, copy) CollectionViewCellConfigureBlock configureCellBlock;
@property (getter=isNibRegistered) BOOL nibRegistered;

@end

static NSString * const cellIdentifier = @"_arrayDataSourceCellID";

@implementation ArrayCollectionViewDataSource

- (id)initWithNibFile:(NSString *)aNibFile
 configureCellBlock:(CollectionViewCellConfigureBlock)aConfigureCellBlock {
  self = [super init];
  if (self) {
    self.nibFile = aNibFile;
    self.configureCellBlock = [aConfigureCellBlock copy];
  }
  
  return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
  return self.items[(NSUInteger) indexPath.row];
}

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  if (!self.isNibRegistered) {
    UINib *nib = [UINib nibWithNibName:self.nibFile bundle: nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:cellIdentifier];
    self.nibRegistered = YES;
  }
  
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
  id item = [self itemAtIndexPath:indexPath];
  
  self.configureCellBlock(cell, item);
  
  return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.items.count;
}

@end
