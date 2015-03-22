//
//  PersonCollectionViewCellDetails.m
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/16/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import "PersonCollectionViewCellDetails.h"
#import "ReactiveCocoa.h"
#import "PersonDetailViewModel.h"

@interface PersonCollectionViewCellDetails()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *notesLabel;
@property (weak, nonatomic) IBOutlet UILabel *twitterLabel;

@end

@implementation PersonCollectionViewCellDetails

- (void)awakeFromNib {
  RAC(self, avatarImageView.image) = RACObserve(self, viewModel.avatar);
  RAC(self, nameLabel.text) = RACObserve(self, viewModel.name);
  RAC(self, notesLabel.text) = RACObserve(self, viewModel.notes);
  RAC(self, twitterLabel.text) = RACObserve(self, viewModel.twitterHandle);
  
  [RACObserve(self, viewModel) subscribeNext:^(id x) {
    self.editButton.rac_command = self.viewModel.editButtonCommand;
  }];
}

@end