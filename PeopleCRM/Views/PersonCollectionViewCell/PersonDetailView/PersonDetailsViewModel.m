//
//  PersonDetailsViewModel.m
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/16/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import "PersonDetailsViewModel.h"

@interface PersonDetailsViewModel()

@property (strong) Person *person;

@end

@implementation PersonDetailsViewModel

- (id)initWithModel:(Person *)person {
  self = [super init];
  
  if (self) {
    self.editButtonCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
      return [RACSignal return:@(YES)];
    }];

    self.person = person;
    
    RAC(self, avatar) = RACObserve(self.person, avatar);
    RAC(self, name) = RACObserve(self.person, name);
    RAC(self, notes) = RACObserve(self.person, notes);
  }
  
  return self;
}

@end
