//
//  FilterViewController.h
//  Yelp
//
//  Created by Patrick Klitzke on 10/26/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwitchTableViewCell.h"

@protocol FilterViewControllerDelegate <NSObject>

- (void)searchForCategory:(NSString *)category
                     sort:(NSString *)sort
                 distance:(NSString *)distance
                     deal:(NSString *)deal;


@end

@interface FilterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SwitchTableViewCellDelegate>

@property (nonatomic, weak) id<FilterViewControllerDelegate> delegate;
@end
