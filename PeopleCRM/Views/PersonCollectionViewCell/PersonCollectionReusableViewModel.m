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

@implementation PersonCollectionReusableViewModel

- (id)initWithModel:(Person *)person {
  self = [super init];
  
  if (self) {
    self.UIState = @(PersonCollectionReusableViewStateDetails);
    
    RACSignal *enabledSignal = [RACObserve(self, UIState) map:^id(NSNumber *state) {
      if ([state integerValue] == PersonCollectionReusableViewStateDetails) {
        return @(YES);
      } else {
        return @(NO);
      }
    }];
    
    self.editButtonCommand = [[RACCommand alloc] initWithEnabled:enabledSignal signalBlock:^RACSignal *(id input) {
      return [RACSignal return:@(YES)];
    }];
    
    self.addTwitterButtonCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
      return [TwitterClient avatarForUsername:@""];
    }];
    
    [self.addTwitterButtonCommand.executionSignals subscribeNext:^(id x) {
      self.avatarSignal = x;
    }];
    
    [[self.addTwitterButtonCommand.executionSignals concat] subscribeNext:^(id x) {
      self.UIState = @(PersonCollectionReusableViewStateDetails);
    }];
    
    [[self.editButtonCommand.executionSignals concat] subscribeNext:^(id x) {
      self.UIState = @(PersonCollectionReusableViewStateAddingStep1);
    }];
  }
  
  return self;
}

@end
