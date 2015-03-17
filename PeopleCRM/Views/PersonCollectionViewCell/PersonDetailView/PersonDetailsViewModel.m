//
//  PersonDetailsViewModel.m
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/16/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import "PersonDetailsViewModel.h"

@implementation PersonDetailsViewModel

- (id)initWithModel:(Person *)person {
  self = [super init];
  
  if (self) {
    self.editButtonCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
      return [RACSignal return:@(YES)];
    }];

    self.avatar = person.avatar;
  }
  
  return self;
}

@end
