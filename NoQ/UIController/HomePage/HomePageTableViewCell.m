//
//  HomePageTableViewCell.m
//  NoQ
//
//  Created by Xiaoxuan Tang on 3/17/14.
//  Copyright (c) 2014 Massvig Ltd.,Co, Shanghai. All rights reserved.
//

#import "HomePageTableViewCell.h"

@implementation HomePageTableViewCell

- (void) dealloc
{
    [super dealloc];
}

- (void) awakeFromNib
{
    [self config];
}

- (void) config
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void) setSelected:(BOOL) selected animated:(BOOL) animated
{
    [super setSelected:selected animated:animated];
}

- (void) initLayers
{
    
}

- (void) showLayers
{
    
}

@end
