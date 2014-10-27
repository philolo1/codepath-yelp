//
//  YelpCell.m
//  Yelp
//
//  Created by Patrick Klitzke on 10/25/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "YelpCell.h"

@implementation YelpCell

- (void)awakeFromNib {
    // Initialization code
  self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
