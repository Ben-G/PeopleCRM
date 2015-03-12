//
//  Person.h
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/10/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import <Foundation/Foundation.h>

// TODO: next step: move this into view model
typedef NS_ENUM(NSInteger, PersonCollectionReusableViewState) {
  PersonCollectionReusableViewStateAddingStep1,
  PersonCollectionReusableViewStateAddingStep2Twitter,
  PersonCollectionReusableViewStateAddingStep2Github,
  PersonCollectionReusableViewStateDetails
};

@interface Person : NSObject

@property (copy) NSString *name;
@property (copy) NSString *twitterUsername;
@property (copy) NSString *notes;
@property (strong) NSNumber *UIState;

@end