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
    self.addTwitterButtonCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
      return [TwitterClient avatarForUsername:@""];
    }];
  }
  
  return self;
}

@end
