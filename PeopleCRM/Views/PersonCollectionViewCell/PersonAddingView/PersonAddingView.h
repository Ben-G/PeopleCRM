//
//  PersonAddingView.h
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/16/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PersonAddingViewModel;

@interface PersonAddingView : UIView

@property (strong, nonatomic) PersonAddingViewModel *viewModel;

@end
