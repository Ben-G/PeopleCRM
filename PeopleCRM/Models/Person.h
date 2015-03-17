//
//  Person.h
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/10/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Person : NSObject

@property (copy) NSString *name;
@property (copy) NSString *twitterUsername;
@property (copy) NSString *notes;
@property (strong) UIImage *avatar;

@end