//
//  PersonCollectionReusableViewModel.m
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/11/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import "PersonCollectionReusableViewModel.h"
#import "Person.h"

@interface PersonCollectionReusableViewModel()

@property (strong, nonatomic) RACDisposable *personUIStateDisposal;

@end

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
    
    [self.personUIStateDisposal dispose];
    
    self.personUIStateDisposal = [[self.editButtonCommand.executionSignals map:^id(id value) {
      return @(PersonCollectionReusableViewStateAddingStep1);
    }] setKeyPath:@"UIState" onObject:self];
  }
  
  return self;
}

@end
