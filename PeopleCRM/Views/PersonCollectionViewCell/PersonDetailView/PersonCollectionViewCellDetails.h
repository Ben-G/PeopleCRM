//
//  PersonCollectionViewCellDetails.h
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/16/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PersonDetailViewModel;

@interface PersonCollectionViewCellDetails : UIView

@property (strong, nonatomic) PersonDetailViewModel *viewModel;

@end