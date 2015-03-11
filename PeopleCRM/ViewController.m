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
  
  //TODO: deactivate all other cells when adding / editing a new one
  
  @weakify(self)
  // Do any additional setup after loading the view, typically from a nib.
  
  self.dataSource = [[ArrayCollectionViewDataSource alloc] initWithNibFile:@"PersonCollectionReusableView" configureCellBlock:^(id cell, id item) {
    
  }];
  
  self.collectionView.dataSource = self.dataSource;
  
  RAC(self.dataSource, items) = [RACObserve(self, people) doNext:^(id x) {
    @strongify(self);
    [self.collectionView reloadData];
  }];
  
  self.addPersonButton.rac_command = [[RACCommand alloc] initWithEnabled:self.editModeSignal signalBlock:^RACSignal *(id input) {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
      @strongify(self);
      self.people = [@[@1] arrayByAddingObjectsFromArray:self.people];
      [subscriber sendCompleted];
      
      return nil;
    }];
  }];
  
  self.people = @[@1, @2, @3, @4];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
