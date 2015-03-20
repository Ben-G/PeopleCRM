//
//  PersonAddingViewModel.m
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/16/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import "PersonAddingViewModel.h"

@interface PersonAddingViewModel()

@property (strong) TwitterClient *twitterClient;

@end

@implementation PersonAddingViewModel

- (id)init {
  return [self initWithTwitterClient:[TwitterClient new]];
}

- (id)initWithTwitterClient:(TwitterClient *)twitterClient {
  self = [super init];
  
  if (self) {
    self.twitterClient = twitterClient;
    
    self.addButtonEnabledSignal = [RACObserve(self, usernameSearchText) map:^id(NSString *searchText) {
      if (!searchText || [searchText  isEqualToString:@""]) {
        return @(NO);
      } else {
        return @(YES);
      }
    }];
    
    self.addTwitterButtonCommand = [[RACCommand alloc] initWithEnabled:self.addButtonEnabledSignal signalBlock:^RACSignal *(id input) {
      RACSignal *signal = [self.twitterClient avatarForUsername:self.usernameSearchText];
      
      return signal;
    }];
    
    // subscribing to RACCommandErrors is special case
    self.errorViewHiddenSignal = [[[[[self.addTwitterButtonCommand.executionSignals concat] merge: self.addTwitterButtonCommand.errors] startWith:@(YES)] map:^id(id value) {
      if ([value isKindOfClass:[NSError class]]) {
        return @(NO);
      } else {
        return @(YES);
      }
    }] replayLast];
  }
  
  return self;
}

@end
