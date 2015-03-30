//
//  Person.m
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/10/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)initWithName:(NSString *)name
                 twitterName:(NSString *)twitterName
                       notes:(NSString *)notes
                      avatar:(UIImage *)avatar {
  self = [super init];
  
  if (self) {
    _name = name;
    _twitterUsername = twitterName;
    _notes = notes;
    _avatar = avatar;
  }
  
  return self;
}

@end
