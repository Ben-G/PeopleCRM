//
//  PersonCollectionReusableView.h
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/11/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PersonCollectionReusableViewModel;

@interface PersonCollectionReusableView : UICollectionReusableView

@property (strong, nonatomic) PersonCollectionReusableViewModel *viewModel;

@end