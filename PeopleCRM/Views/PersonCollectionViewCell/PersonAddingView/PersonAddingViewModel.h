//
//  PersonAddingViewModel.h
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/16/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"
#import "TwitterClient.h"

@interface PersonAddingViewModel : NSObject

@property (strong) RACCommand *addTwitterButtonCommand;
@property (strong) RACSignal *errorViewHiddenSignal;
@property (strong) NSString *usernameSearchText;
@property (strong) RACSignal *addButtonEnabledSignal;

- (id)initWithTwitterClient:(TwitterClient *)twitterClient;

@end