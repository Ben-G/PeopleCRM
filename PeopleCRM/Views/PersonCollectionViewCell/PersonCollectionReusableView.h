//
//  PersonCollectionReusableView.h
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/11/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@interface PersonCollectionReusableView : UICollectionReusableView

@property (strong, nonatomic) Person *person;

@end