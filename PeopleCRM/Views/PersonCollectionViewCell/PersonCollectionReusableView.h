//
//  PersonCollectionReusableView.h
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/11/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Person;

typedef NS_ENUM(NSInteger, PersonCollectionReusableViewState) {
  PersonCollectionReusableViewStateAddingStep1,
  PersonCollectionReusableViewStateAddingStep2Twitter,
  PersonCollectionReusableViewStateAddingStep2Github,
  PersonCollectionReusableViewStateDetails
};

@interface PersonCollectionReusableView : UICollectionReusableView

@property (assign, nonatomic) NSNumber *UIState;
@property (strong, nonatomic) Person *person;

@end