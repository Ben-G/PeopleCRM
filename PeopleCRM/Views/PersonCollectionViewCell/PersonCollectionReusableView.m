//
//  PersonCollectionReusableView.m
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/11/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import "PersonCollectionReusableView.h"
#import "ReactiveCocoa.h"
#import "PersonCollectionReusableViewModel.h"

@interface PersonCollectionReusableView()

@property (weak, nonatomic) IBOutlet UIView *innerContentView;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *addTwitterButton;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (strong, nonatomic) UIView *presentedView;

@property (strong, nonatomic) RACDisposable *avatarDisposable;

@end

@implementation PersonCollectionReusableView

- (void)awakeFromNib {
  @weakify(self)
  
  [RACObserve(self, editButton) subscribeNext:^(UIButton *editButton) {
    editButton.rac_command = self.viewModel.editButtonCommand;
  }];
  
  [RACObserve(self, addTwitterButton) subscribeNext:^(UIButton *addTwitterButton) {
    addTwitterButton.rac_command = self.viewModel.addTwitterButtonCommand;
  }];
  
  RAC(self, presentedView) = [RACObserve(self, viewModel.UIState) map:^id(NSNumber *state) {
    switch ([state integerValue]) {
      case PersonCollectionReusableViewStateDetails:
        return [[[NSBundle mainBundle] loadNibNamed:@"PersonCollectionViewCellDetails" owner:self options:nil] objectAtIndex:0];
        break;
      case PersonCollectionReusableViewStateAddingStep1:
        return [[[NSBundle mainBundle] loadNibNamed:@"PersonCollectionViewAdding" owner:self options:nil] objectAtIndex:0];
        break;
      default:
        return nil;
        break;
    }
  }];
  
  RACSignal *avatarSignalChangeSignal = RACObserve(self, viewModel.avatarSignal);
  RACSignal *imageViewChangeSignal = RACObserve(self, avatar);
  
  RACSignal *imageBindSignal = [avatarSignalChangeSignal merge:imageViewChangeSignal];
  
  [imageBindSignal subscribeNext:^(id x) {
    //TODO: use signal operator instead of nested subscription as suggested in http://stackoverflow.com/questions/21205366/reactivecocoa-disposing-of-a-repeating-signal ?
    @strongify(self)
    //TODO: check wether signal or imageview changed
    [self.avatarDisposable dispose];
    self.avatarDisposable =
    [[self.viewModel.avatarSignal deliverOnMainThread] setKeyPath:@"avatar.image" onObject:self];
  }];
  
  [RACObserve(self, presentedView) subscribeNext:^(UIView *newView) {
    [self.innerContentView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    [self.innerContentView addSubview:newView];
  }];
}

@end