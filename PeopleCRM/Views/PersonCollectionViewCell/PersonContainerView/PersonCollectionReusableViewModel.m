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
    self.UIState = @(PersonCollectionReusableViewStateAddingTwitter);
    
    RACSignal *twitterFetchSignal = [RACObserve(self, personAddingViewModel) flattenMap:^RACStream *(id value) {
      return [self.personAddingViewModel.addTwitterButtonCommand.executionSignals concat];
    }];
    
    RACSignal *UIStateSignal1 = [[RACObserve(self, personDetailsViewModel) flattenMap:^RACStream *(id value) {
      return [self.personDetailsViewModel.editButtonCommand.executionSignals concat];
    }] map:^id(id value) {
      return @(PersonCollectionReusableViewStateAddingTwitter);
    }];
    
    RACSignal *UIStateSignal2 = [twitterFetchSignal map:^id(id value) {
      return @(PersonCollectionReusableViewStateDetails);
    }];
        
    RACSignal *mergeSignal = [UIStateSignal1 merge:UIStateSignal2];
    
    RAC(self, UIState) = mergeSignal;
    
    RAC(self.person, avatar) = [twitterFetchSignal reduceEach:^id(UIImage *avatar, NSDictionary *userInfo){
      return avatar;
    }];
    
    RAC(self.person, name) = [twitterFetchSignal reduceEach:^id(UIImage *avatar, NSDictionary *userInfo){
      return userInfo[@"name"];
    }];
    
    RAC(self.person, notes) = [twitterFetchSignal reduceEach:^id(UIImage *avatar, NSDictionary *userInfo){
      return userInfo[@"description"];
    }];
  }
  
  return self;
}


- (id)viewModelforUIState {
  switch ([self.UIState integerValue]) {
    case PersonCollectionReusableViewStateDetails:
      return self.personDetailsViewModel;
      break;
    case PersonCollectionReusableViewStateAddingTwitter:
      return self.personAddingViewModel;
      break;
    default:
      assert(false);
      return nil;
      break;
  }
}

#pragma mark - Property Getter/Setter overrides

- (PersonDetailsViewModel *)personDetailsViewModel {
  if (!_personDetailsViewModel) {
    _personDetailsViewModel = [[PersonDetailsViewModel alloc] initWithModel:self.person];
  }
  
  return _personDetailsViewModel;
}

- (PersonAddingViewModel *)personAddingViewModel {
  if (!_personAddingViewModel) {
    _personAddingViewModel = [[PersonAddingViewModel alloc] init];
  }
  
  return _personAddingViewModel;
}

@end
