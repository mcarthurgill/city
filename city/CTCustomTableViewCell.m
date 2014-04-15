//
//  CTCustomTableViewCell.m
//  city
//
//  Created by Joseph McArthur Gill on 2/20/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import "CTCustomTableViewCell.h"

@implementation CTCustomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
