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

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) ArrayCollectionViewDataSource *dataSource;
@property (strong) NSArray *people;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  self.dataSource = [[ArrayCollectionViewDataSource alloc] initWithNibFile:@"PersonCollectionViewCell" configureCellBlock:^(id cell, id item) {
    
  }];
  
  self.collectionView.dataSource = self.dataSource;
  
  RAC(self.dataSource, items) = [RACObserve(self, people) doNext:^(id x) {
    [self.collectionView reloadData];
  }];
  
  self.people = @[@1, @2, @3, @4];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
