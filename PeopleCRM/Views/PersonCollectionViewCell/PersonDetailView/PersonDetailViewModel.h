//
//  PersonDetailsViewModel.h
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/16/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"
#import "Person.h"

@interface PersonDetailViewModel : NSObject

@property (strong) RACCommand *editButtonCommand;
@property (strong, readonly) UIImage *avatar;
@property (strong, readonly) NSString *name;
@property (strong, readonly) NSString *notes;
@property (strong, readonly) NSString *twitterHandle;
@property (strong) Person *person;

@end