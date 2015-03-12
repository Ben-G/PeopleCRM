//
//  PersonCollectionReusableView.m
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/11/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import "PersonCollectionReusableView.h"
#import "ReactiveCocoa.h"

@interface PersonCollectionReusableView()

@property (weak, nonatomic) IBOutlet UIView *innerContentView;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (strong, nonatomic) UIView *presentedView;

@property (strong, nonatomic) RACDisposable *personUIStateDisposal;

@end

@implementation PersonCollectionReusableView

- (void)awakeFromNib {
  RACSignal *enabledSignal = [RACObserve(self, person.UIState) map:^id(NSNumber *state) {
    if ([state integerValue] == PersonCollectionReusableViewStateDetails) {
      return @(YES);
    } else {
      return @(NO);
    }
  }];
  
  [RACObserve(self, editButton) subscribeNext:^(UIButton *editButton) {
    editButton.rac_command = [[RACCommand alloc] initWithEnabled:enabledSignal signalBlock:^RACSignal *(id input) {
      return [RACSignal return:@(YES)];
    }];
    
    [self.personUIStateDisposal dispose];
    
    self.personUIStateDisposal = [[self.editButton.rac_command.executionSignals map:^id(id value) {
      return @(PersonCollectionReusableViewStateAddingStep1);
    }] setKeyPath:@"person.UIState" onObject:self];
  }];
  
  RAC(self, presentedView) = [RACObserve(self, person.UIState) map:^id(NSNumber *state) {
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
  
  [RACObserve(self, presentedView) subscribeNext:^(UIView *newView) {
    [self.innerContentView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    [self.innerContentView addSubview:newView];
  }];
}

@end