//
//  PersonDetailViewModelTest.m
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/19/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Specta.h"
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>

#import "PersonDetailViewModel.h"

SpecBegin(PersonDetailViewModel)

__block PersonDetailViewModel *viewModel;
__block Person *person;

beforeEach(^{
  person = [[Person alloc] init];
  person.name = @"Benjamin Encz";
  person.twitterUsername = @"benjaminencz";
  person.notes = @"Test content";
  viewModel = [[PersonDetailViewModel alloc] initWithModel:person];
});

afterEach(^{
  person = nil;
  viewModel = nil;
});

SpecEnd