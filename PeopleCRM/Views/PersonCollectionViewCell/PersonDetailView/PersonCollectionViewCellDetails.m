//
//  PersonCollectionViewCellDetails.m
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/16/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import "PersonCollectionViewCellDetails.h"
#import "ReactiveCocoa.h"
#import "PersonDetailsViewModel.h"

@interface PersonCollectionViewCellDetails()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

@end

@implementation PersonCollectionViewCellDetails

- (void)awakeFromNib {
  RAC(self, avatarImageView.image) = RACObserve(self, viewModel.avatar);
  
  [RACObserve(self, viewModel) subscribeNext:^(id x) {
    self.editButton.rac_command = self.viewModel.editButtonCommand;
  }];
}

@end