//
//  Person.m
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/10/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id)init {
  self = [super init];
  
  if (self) {
    self.UIState = @(PersonCollectionReusableViewStateDetails);
  }
  
  return self;
}

@end
