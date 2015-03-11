//
//  ArrayCollectionViewDataSource.h
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/10/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

/* Thx to Chris Eidhoff for introducing this concept */

#import <UIKit/UIKit.h>

typedef void (^CollectionViewCellConfigureBlock)(id cell, id item);

@interface ArrayCollectionViewDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *items;

- (id)initWithNibFile:(NSString *)aNibFile
 configureCellBlock:(CollectionViewCellConfigureBlock)aConfigureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end