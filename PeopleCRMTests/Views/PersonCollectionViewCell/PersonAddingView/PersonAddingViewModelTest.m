//
//  PersonAddingViewModel.m
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/19/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Specta.h"
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import "PersonAddingViewModel.h"
#import "TwitterClient.h"

SpecBegin(PersonAddingViewModel)

__block PersonAddingViewModel *viewModel;

beforeEach(^{
  viewModel = [[PersonAddingViewModel alloc] init];
});

describe(@"PersonDetailViewModel_addButton", ^{
  
  it(@"disables add command when username search text is empty", ^{
    viewModel.usernameSearchText = @"";
    __block id result;
    [viewModel.addButtonEnabledSignal subscribeNext:^(id x) {
      result = x;
    }];
    expect(result).to.equal(@(NO));
  });
  
  it(@"enables add command when username search text is not empty", ^{
    viewModel.usernameSearchText = @"username";
    __block id result;
    [viewModel.addButtonEnabledSignal subscribeNext:^(id x) {
      result = x;
    }];
    expect(result).to.equal(@(YES));
  });
  
  it(@"calls the Twitter API when add button is tapped", ^{
    id twitterClient = [TwitterClient new];
    id twitterMock = OCMPartialMock(twitterClient);
    OCMStub([twitterMock infoForUsername:@"username"]).andReturn([RACSignal return:@(YES)]);
    
    viewModel = [[PersonAddingViewModel alloc] initWithTwitterClient:twitterMock];
    viewModel.usernameSearchText = @"username";
    [viewModel.addTwitterButtonCommand execute:nil];
    
    OCMVerify([twitterMock infoForUsername:@"username"]);
  });
  
});

describe(@"PersonDetailViewModel_errorMessage", ^{
  
  it(@"shows an error message when twitter operation fails", ^{
    id twitterClient = [TwitterClient new];
    id twitterMock = OCMPartialMock(twitterClient);
    RACSignal *signal = [RACSignal error:[NSError new]];
    OCMStub([twitterMock infoForUsername:[OCMArg any]]).andReturn(signal);
    
    viewModel = [[PersonAddingViewModel alloc] initWithTwitterClient:twitterClient];
    // enable command
    viewModel.usernameSearchText = @"validcontent";
    
    __block id result;
    
    [viewModel.errorViewHiddenSignal subscribeNext:^(id x) {
      result = x;
    }];
    
    [[viewModel.addTwitterButtonCommand execute:nil] asynchronouslyWaitUntilCompleted:nil];
    
    expect(result).to.equal(@(NO)); // expect error view to be visible
  });
  
});



afterEach(^{
  viewModel = nil;
});

SpecEnd