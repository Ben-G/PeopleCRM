//
//  TwitterClient.m
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/13/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import "TwitterClient.h"
#import "STTwitter.h"
#import "AFNetworking.h"
#import "RACAFNetworking.h"

@implementation TwitterClient

- (RACSignal *)infoForUsername:(NSString *)username {
  RACScheduler *bgScheduler =
    [RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground];
  
  return [[[[self _login]
    deliverOn:bgScheduler]
    flattenMap:^RACStream *(STTwitterAPI *client) {
    return [self client:client fetchUserInfo:username];
  }] flattenMap:^RACStream *(NSDictionary *userInfo) {
    NSDictionary *userDetails = @{@"name": userInfo[@"name"],
                                  @"description": userInfo[@"description"],
                                  @"twitterHandle": userInfo[@"screen_name"]};
    
    NSString *downloadURL = [userInfo[@"profile_image_url_https"]
      stringByReplacingOccurrencesOfString:@"normal" withString:@"bigger"];
    
    return [[self imageFromURLString:downloadURL]
            combineLatestWith:[RACSignal return:userDetails]];
  }];
}

- (RACSignal *)client:(STTwitterAPI *)client fetchUserInfo:(NSString *)username {
  return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {

    [client getUserInformationFor:username successBlock:^(NSDictionary *user) {
      [subscriber sendNext:user];
      [subscriber sendCompleted];
    } errorBlock:^(NSError *error) {
      [subscriber sendError:error];
    }];
    
    return nil;
  }];
};

//TODO: move image download out
- (RACSignal *)imageFromURLString:(NSString *)urlString {
  AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]
                                            initWithBaseURL:nil];
  manager.responseSerializer = [AFImageResponseSerializer serializer];
  
  return [manager rac_GET:urlString parameters:nil];
}

#pragma mark - Private Methods

static NSDictionary *_twitterCredentials;
static STTwitterAPI *_twitterClient;

- (RACSignal *)_login {
  return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {

    if (!_twitterCredentials) {
      NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Twitter_API_Keys" ofType:@"plist"];
      _twitterCredentials = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    }
    
    if (!_twitterClient) {
      _twitterClient =     [STTwitterAPI twitterAPIAppOnlyWithConsumerKey:_twitterCredentials[@"consumer_key"] consumerSecret:_twitterCredentials[@"consumer_secret"]];
      
      [_twitterClient verifyCredentialsWithSuccessBlock:^(NSString *username) {
        [subscriber sendNext:_twitterClient];
        [subscriber sendCompleted];
      } errorBlock:^(NSError *error) {
        [subscriber sendError:error];
      }];
    } else {
      [subscriber sendNext:_twitterClient];
      [subscriber sendCompleted];
    }
    
    // cannot cancel API request
    return nil;
  }];
}

@end
