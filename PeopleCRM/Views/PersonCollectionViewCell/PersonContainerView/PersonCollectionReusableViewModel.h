//
//  PersonCollectionReusableViewModel.h
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/11/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@class Person;

typedef NS_ENUM(NSInteger, PersonCollectionReusableViewState) {
  PersonCollectionReusableViewStateAddingTwitter,
  PersonCollectionReusableViewStateDetails
};

@interface PersonCollectionReusableViewModel : NSObject

@property (strong) NSNumber *UIState;

- (id)initWithModel:(Person *)person;
- (id)viewModelforUIState;

@end