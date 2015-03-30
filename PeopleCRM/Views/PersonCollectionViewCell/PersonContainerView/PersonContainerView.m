//
//  PersonCollectionReusableView.m
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/11/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import "PersonContainerView.h"
#import "ReactiveCocoa.h"
#import "PersonContainerViewModel.h"

@interface PersonContainerView()

@property (weak, nonatomic) IBOutlet UIView *innerContentView;
@property (strong, nonatomic) UIView *presentedView;

@end

@implementation PersonContainerView

- (void)awakeFromNib {
  RAC(self, presentedView) = [RACObserve(self, viewModel.UIState) map:^id(NSNumber *state) {
    switch ([state integerValue]) {
      case PersonCollectionReusableViewStateDetails:
        return [[[NSBundle mainBundle] loadNibNamed:@"PersonDetailView" owner:self options:nil] objectAtIndex:0];
        break;
      case PersonCollectionReusableViewStateAddingTwitter:
        return [[[NSBundle mainBundle] loadNibNamed:@"PersonAddingView" owner:self options:nil] objectAtIndex:0];
        break;
      default:
        return nil;
        break;
    }
  }];
  
  [RACObserve(self, presentedView) subscribeNext:^(UIView *newView) {
    [self.innerContentView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    [self.innerContentView addSubview:newView];
    
    newView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.innerContentView addConstraint:[NSLayoutConstraint constraintWithItem:newView
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.innerContentView
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:0.0]];
    
    [self.innerContentView addConstraint:[NSLayoutConstraint constraintWithItem:newView
                                                              attribute:NSLayoutAttributeLeading
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.innerContentView
                                                              attribute:NSLayoutAttributeLeading
                                                             multiplier:1.0
                                                               constant:0.0]];
    
    [self.innerContentView addConstraint:[NSLayoutConstraint constraintWithItem:newView
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.innerContentView
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:0.0]];
    
    [self.innerContentView addConstraint:[NSLayoutConstraint constraintWithItem:newView
                                                              attribute:NSLayoutAttributeTrailing
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.innerContentView
                                                              attribute:NSLayoutAttributeTrailing
                                                             multiplier:1.0
                                                               constant:0.0]];
    
    
    id viewModel = [self.viewModel viewModelforUIState];
    id newViewID = (id) newView;
    [newViewID setViewModel:viewModel];
  }];
}

@end