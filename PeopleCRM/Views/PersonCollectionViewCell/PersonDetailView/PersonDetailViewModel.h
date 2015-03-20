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
@property (strong) UIImage *avatar;
@property (strong) NSString *name;
@property (strong) NSString *notes;

- (id)initWithModel:(Person *)person;

@end