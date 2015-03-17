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
@property (strong, nonatomic) UIView *presentedView;

@end

@implementation PersonCollectionReusableView

- (void)awakeFromNib {
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
  
  [RACObserve(self, presentedView) subscribeNext:^(UIView *newView) {
    [self.innerContentView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    [self.innerContentView addSubview:newView];
    
    id viewModel = [self.viewModel viewModelforUIState];
    id newViewID = (id) newView;
    [newViewID setViewModel:viewModel];
  }];
}

@end