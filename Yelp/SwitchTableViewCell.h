//
//  SwitchTableViewCell.h
//  Yelp
//
//  Created by Patrick Klitzke on 10/26/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SwitchTableViewCellDelegate <NSObject>

- (void)didSelectCodeLabel:(NSString *)codeLabel;
- (void)didDeselectCodeLabel:(NSString *)codeLabel;

@end

@interface SwitchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) UILabel *codeLabel;

@property (nonatomic, weak) id<SwitchTableViewCellDelegate> delegate;

@end

