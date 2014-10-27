//
//  SwitchTableViewCell.m
//  Yelp
//
//  Created by Patrick Klitzke on 10/26/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "SwitchTableViewCell.h"

@implementation SwitchTableViewCell

- (void)awakeFromNib {
    // Initialization code
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  self.codeLabel = [[UILabel alloc] init];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)valueChanged:(id)sender {
  NSString *codeLabelString = [[self codeLabel] text];
  
  if ([sender isOn]) {
    [self.delegate didSelectCodeLabel:codeLabelString];
  } else {
    [self.delegate didDeselectCodeLabel:codeLabelString];
  }
}




@end
