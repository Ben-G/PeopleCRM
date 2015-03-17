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
    self.UIState = @(PersonCollectionReusableViewStateAddingStep1);
    
//    RACSignal *imageSignal = [self.addTwitterButtonCommand.executionSignals concat];
    RAC(self, avatar) = imageSignal;
    
    RACSignal *UIStateSignal1 = [[self.addTwitterButtonCommand.executionSignals concat] map:^id(id value) {
      return @(PersonCollectionReusableViewStateDetails);
    }];
    
    RACSignal *UIStateSignal2 = [[self.editButtonCommand.executionSignals concat] map:^id(id value) {
      return @(PersonCollectionReusableViewStateAddingStep1);
    }];
    
    RACSignal *mergeSignal = [UIStateSignal1 merge:UIStateSignal2];
    
    RAC(self, UIState) = mergeSignal;
  }
  
  return self;
}

@end
