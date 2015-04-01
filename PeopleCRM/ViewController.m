//
//  ViewController.m
//  PeopleCRM
//
//  Created by Benjamin Encz on 3/10/15.
//  Copyright (c) 2015 Benjamin Encz. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveCocoa.h"
#import "ArrayCollectionViewDataSource.h"
#import "Person.h"
#import "PersonContainerView.h"
#import "PersonContainerViewModel.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addPersonButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) ArrayCollectionViewDataSource *dataSource;
@property (strong) NSArray *people;
@property (strong) RACSignal *editModeSignal;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  @weakify(self)
  
  self.dataSource = [[ArrayCollectionViewDataSource alloc] initWithNibFile:@"PersonContainerView" configureCellBlock:^(PersonContainerView *cell, PersonContainerViewModel *viewModel) {
      cell.viewModel = viewModel;
  }];
  
  self.collectionView.dataSource = self.dataSource;
  
  RAC(self.dataSource, items) = [RACObserve(self, people) doNext:^(id x) {
    @strongify(self);
    // reload the table view whenever the list of view models changes
    [self.collectionView reloadData];
  }];
  
  self.addPersonButton.rac_command = [[RACCommand alloc] initWithEnabled:self.editModeSignal signalBlock:^RACSignal *(id input) {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
      PersonContainerViewModel *person = [[PersonContainerViewModel alloc] initWithModel:[Person new]];
      [subscriber sendNext:person];
      [subscriber sendCompleted];
      
      return nil;
    }];
  }];
  
  [[self.addPersonButton.rac_command.executionSignals concat] subscribeNext:^(PersonContainerViewModel
 *person) {
    self.people = [@[person] arrayByAddingObjectsFromArray:self.people];
  }];
  
  PersonContainerViewModel *person1 = [[PersonContainerViewModel alloc] initWithModel:[Person new]];
  PersonContainerViewModel *person2 = [[PersonContainerViewModel alloc] initWithModel:[Person new]];
  PersonContainerViewModel *person3 = [[PersonContainerViewModel alloc] initWithModel:[Person new]];
  PersonContainerViewModel *person4 = [[PersonContainerViewModel alloc] initWithModel:[Person new]];
  
  self.people = @[person1, person2, person3, person4];
}

@end
