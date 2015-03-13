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

// TODO: next step: move this into view model
typedef NS_ENUM(NSInteger, PersonCollectionReusableViewState) {
  PersonCollectionReusableViewStateAddingStep1,
  PersonCollectionReusableViewStateAddingStep2Twitter,
  PersonCollectionReusableViewStateAddingStep2Github,
  PersonCollectionReusableViewStateDetails
};

@interface PersonCollectionReusableViewModel : NSObject

@property (strong) NSNumber *UIState;
@property (strong) Person *person;
@property (strong) RACCommand *editButtonCommand;
@property (strong) RACCommand *addTwitterButtonCommand;

- (id)initWithModel:(Person *)person;

@end