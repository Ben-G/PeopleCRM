//
//  PersonCollectionReusableView.h
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/11/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PersonContainerViewModel;

@interface PersonContainerView : UICollectionReusableView

@property (strong, nonatomic) PersonContainerViewModel *viewModel;

@end