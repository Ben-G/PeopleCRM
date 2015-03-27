//
//  TwitterClient.h
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/13/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface TwitterClient : NSObject

- (RACSignal *)infoForUsername:(NSString *)username;

@end