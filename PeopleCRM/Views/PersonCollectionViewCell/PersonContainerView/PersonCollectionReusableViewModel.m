//
//  PersonCollectionReusableViewModel.m
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/11/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import "PersonCollectionReusableViewModel.h"
#import "Person.h"
#import "TwitterClient.h"

#import "PersonDetailsViewModel.h"
#import "PersonAddingViewModel.h"

@interface PersonCollectionReusableViewModel()

@property (strong, nonatomic) Person *person;
@property (strong, nonatomic) PersonDetailsViewModel *personDetailsViewModel;
@property (strong, nonatomic) PersonAddingViewModel *personAddingViewModel;

@end

@implementation PersonCollectionReusableViewModel

- (id)initWithModel:(Person *)person {
  self = [super init];
  
  if (self) {
    self.person = person;
    self.UIState = @(PersonCollectionReusableViewStateAddingStep1);
    
    RACSignal *twitterFetchSignal = [RACObserve(self, personAddingViewModel) flattenMap:^RACStream *(id value) {
      return [self.personAddingViewModel.addTwitterButtonCommand.executionSignals concat];
    }];
    
    RACSignal *UIStateSignal1 = [[RACObserve(self, personDetailsViewModel) flattenMap:^RACStream *(id value) {
      return [self.personDetailsViewModel.editButtonCommand.executionSignals concat];
    }] map:^id(id value) {
      return @(PersonCollectionReusableViewStateAddingStep1);
    }];
    
    RACSignal *UIStateSignal2 = [twitterFetchSignal map:^id(id value) {
      return @(PersonCollectionReusableViewStateDetails);
    }];
        
    RACSignal *mergeSignal = [UIStateSignal1 merge:UIStateSignal2];
    
    RAC(self, UIState) = mergeSignal;
    RAC(self.person, avatar) = twitterFetchSignal;
  }
  
  return self;
}


- (id)viewModelforUIState {
  switch ([self.UIState integerValue]) {
    case PersonCollectionReusableViewStateDetails:
      return self.personDetailsViewModel = [[PersonDetailsViewModel alloc] initWithModel:self.person];
      break;
    case PersonCollectionReusableViewStateAddingStep1:
      return self.personAddingViewModel = [[PersonAddingViewModel alloc] init];
      break;
    default:
      assert(false);
      return nil;
      break;
  }
}

@end
