//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "YelpClient.h"
#import "YelpCell.h"
#import "UIImageView+AFNetworking.h"
#import "FilterViewController.h"

#include <stdlib.h>


NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface MainViewController ()

@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchController;

@property (nonatomic, copy) NSString *categoryFilterString;
@property (nonatomic, copy) NSString *dealFilterString;
@property (nonatomic, copy) NSString *sortFilterString;
@property (nonatomic, copy) NSString *distanceFilterString;

@end

@implementation MainViewController
{
  NSArray *_results;
  NSUInteger _count;
}

- (void)searchForText:(NSString *)searchText
{
  [self.client searchWithTerm:searchText
                     category:_categoryFilterString
                     distance:_distanceFilterString
                         sort:_sortFilterString
                         deal:_dealFilterString
                      success:^(AFHTTPRequestOperation *operation, id response) {
    NSLog(@"response: %@", response);
    
    _results = response[@"businesses"];
                        
    [self.tableView reloadData];
    if ([_results count] > 0) {
       [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                          atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    
    
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"error: %@", [error description]);
  }];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
      
      
      
      [self searchForText:@"Thai"];
      
      UISearchBar *label = [[UISearchBar alloc] initWithFrame:CGRectMake(100,000, 200,30)];
      
      
      self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(50, 0, 200, 30)];
      [self.searchBar setAutocorrectionType:UITextAutocorrectionTypeNo];
      [self.searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
      
      self.searchBar.delegate = self;
      
      self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
      [self.searchController setDelegate:self];
      [self.searchController setSearchResultsDataSource:self];
      [self.searchController setSearchResultsDelegate:self];
      
      
      self.navigationItem.titleView = self.searchController.searchBar;
      
      UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
      button.frame = CGRectMake(10, 0, 50, 30);
      [button setTitle:@"Filter" forState:UIControlStateNormal];
      [button addTarget:self action:@selector(didFilterTapped) forControlEvents:UIControlEventTouchUpInside];
      
      
      

      UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithCustomView:button];
      self.navigationItem.leftBarButtonItem = btn;
      
      
     
      
      [self.navigationController.navigationBar addSubview:label];
      

      
      
    }
    return self;
}

- (void)didFilterTapped
{  
  FilterViewController *vc = [[FilterViewController alloc] init];
  vc.delegate = self;
  
  UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
  [nvc.navigationBar setBarTintColor:[UIColor redColor]];
  [nvc.navigationBar setTintColor:[UIColor whiteColor]];
  [nvc.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
  
  
  [self.navigationController presentViewController:nvc animated:YES completion:nil];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
  NSLog(@"searchtext : %@", searchText);
  [self searchForText:searchText];

}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  
  UINib *movieCellNib = [UINib nibWithNibName:@"YelpCell" bundle:nil];
  [self.tableView registerNib:movieCellNib forCellReuseIdentifier:@"YelpCell"];
  self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)viewWillAppear:(BOOL)animated
{
  [self.tableView reloadData];
}

#pragma mark - Table view methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return _results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  YelpCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YelpCell" forIndexPath:indexPath];
  
  NSDictionary *data = _results[indexPath.row];
  
  NSString *url = data[@"image_url"];
  [cell.myImageView setImageWithURL:[NSURL URLWithString:url]];
  
  url = data[@"rating_img_url_large"];
  [cell.rankingImageView setImageWithURL:[NSURL URLWithString:url]];
  
  cell.titleLabel.text = data[@"name"];
  cell.locationLabel.text = data[@"location"][@"cross_streets"];
  cell.reviewLabel.text = [NSString stringWithFormat:@"%@ reviews", data[@"review_count"]];
  
  NSArray *cat = data[@"categories"];
  
  NSString *res = @"";
  
  for (NSArray *help in cat) {
    if (res.length > 0) { res = [res stringByAppendingString:@", "]; }
   res = [res stringByAppendingString:help[0]];
  }
  
  cell.categoryLabel.text = res;
  
  int r = arc4random_uniform(4)+1;
  
  NSString *dollarString = @"";
  for (int i=0; i<r; i++) {
    dollarString = [dollarString stringByAppendingString:@"$"];
  }
  
  cell.priceLabel.text = dollarString;
  
  return cell;
}

#pragma mark FilterViewerDelegega
-(void)searchForCategory:(NSString *)category sort:(NSString *)sort distance:(NSString *)distance deal:(NSString *)deal
{
  _categoryFilterString = category;
  _dealFilterString = deal;
  _sortFilterString = sort;
  _distanceFilterString = distance;
  [self searchForText:@""];
}

@end
