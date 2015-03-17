//
//  PersonAddingView.m
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/16/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import "PersonAddingView.h"
#import "PersonAddingViewModel.h"
#import "ReactiveCocoa.h"

@interface PersonAddingView()

@property (weak, nonatomic) IBOutlet UIButton *addTwitterButton;

@end

@implementation PersonAddingView

- (void)awakeFromNib {
  [RACObserve(self, viewModel) subscribeNext:^(id x) {
    self.addTwitterButton.rac_command = self.viewModel.addTwitterButtonCommand;
  }];
}

@end