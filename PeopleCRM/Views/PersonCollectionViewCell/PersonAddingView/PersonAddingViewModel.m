//
//  PersonAddingViewModel.m
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/16/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import "PersonAddingViewModel.h"
#import "TwitterClient.h"

@implementation PersonAddingViewModel

- (id)init {
  self = [super init];
  
  if (self) {
    RACSignal *searchTextSignal = [RACObserve(self, usernameSearchText) map:^id(NSString *searchText) {
      if (!searchText || [searchText  isEqualToString:@""]) {
        return @(NO);
      } else {
        return @(YES);
      }
    }];
    
    self.addTwitterButtonCommand = [[RACCommand alloc] initWithEnabled:searchTextSignal signalBlock:^RACSignal *(id input) {
      RACSignal *signal = [TwitterClient avatarForUsername:self.usernameSearchText];
      
      return signal;
    }];
    
    self.errorViewHiddenSignal = [[self.addTwitterButtonCommand.executionSignals concat] catch:^RACSignal *(NSError *error) {
      return [RACSignal return:@(NO)];
    }];
    
    // subscribing to RACCommandErrors is special case
    self.errorViewHiddenSignal = [[[[self.addTwitterButtonCommand.executionSignals concat] merge: self.addTwitterButtonCommand.errors] startWith:@(YES)] map:^id(id value) {
      if ([value isKindOfClass:[NSError class]]) {
        return @(NO);
      } else {
        return @(YES);
      }
    }];
  }
  
  return self;
}

@end
