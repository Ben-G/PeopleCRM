//
//  PersonCollectionReusableView.m
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/11/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import "PersonCollectionReusableView.h"


@interface PersonCollectionReusableView()

@property (weak, nonatomic) IBOutlet UIView *innerContentView;

@end

@implementation PersonCollectionReusableView

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  
  if (self) {

  }
  
  return self;
}

- (void)awakeFromNib {
  UIView *subview = [[[NSBundle mainBundle] loadNibNamed:@"PersonCollectionViewCellDetails" owner:self options:nil] objectAtIndex:0];
  
  [self.innerContentView addSubview:subview];
}

@end