//
//  TwitterClient.m
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/13/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import "TwitterClient.h"
#import "STTwitter.h"


@implementation TwitterClient

+ (void)avatarForUsername:(NSString *)username {
  STTwitterAPI *client = [TwitterClient _client];
  [client verifyCredentialsWithSuccessBlock:^(NSString *username) {
    [client getUserInformationFor:@"benjaminencz" successBlock:^(NSDictionary *user) {
      
    } errorBlock:^(NSError *error) {
      
    }];
  } errorBlock:^(NSError *error) {
    
  }];
}


#pragma mark - Private Methods

static NSDictionary *_twitterCredentials;
static STTwitterAPI *_twitterClient;

+ (STTwitterAPI *)_client {
  if (!_twitterCredentials) {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Twitter_API_Keys" ofType:@"plist"];
    _twitterCredentials = [NSDictionary dictionaryWithContentsOfFile:plistPath];
  }
  
  if (!_twitterClient) {
    _twitterClient =     [STTwitterAPI twitterAPIAppOnlyWithConsumerKey:_twitterCredentials[@"consumer_key"] consumerSecret:_twitterCredentials[@"consumer_secret"]];
  }
  
  return _twitterClient;
}

@end
