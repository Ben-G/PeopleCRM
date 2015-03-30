//
//  Person.h
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/10/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Person : NSObject

@property (readonly) NSString *name;
@property (readonly) NSString *twitterUsername;
@property (readonly) NSString *notes;
@property (readonly) UIImage *avatar;

- (instancetype)initWithName:(NSString *)name twitterName:(NSString *)twitterName
                       notes:(NSString *)notes avatar:(UIImage *)avatar;

@end