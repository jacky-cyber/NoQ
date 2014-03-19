//
//  BadgeButton.m
//  NoQ
//
//  Created by Xiaoxuan Tang on 3/14/14.
//  Copyright (c) 2014 Massvig Ltd.,Co, Shanghai. All rights reserved.
//

#import "BadgeButton.h"

@interface BadgeButton()

@property (nonatomic, retain) UIImageView *badgeImageView;
@property (nonatomic, retain) UILabel *badgeLabel;
@property (nonatomic, copy) NSString *badgeString;
 
@end

@implementation BadgeButton

- (void) dealloc
{
    [super dealloc];
    SAFE_RELEASE(_badgeImageView);
    SAFE_RELEASE(_badgeString);
    SAFE_RELEASE(_badgeLabel);
}

- (id) initWithFrame:(CGRect) frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self configWidgets];
        self.badgeValue = 0;
    }
    return self;
}

- (id) initWithCoder:(NSCoder *) aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self configWidgets];
        self.badgeValue = 5;
    }
    return self;
}

- (void) configWidgets
{
    _badgeImageView = [[UIImageView alloc] initWithImage:IMAGE(@"homepage_naviBadge")];
    UIView *badgeContainer = [[UIView alloc] initWithFrame:_badgeImageView.frame];
    [badgeContainer addSubview:_badgeImageView];
    
    _badgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 10)];
    _badgeLabel.center = _badgeImageView.center;
    _badgeLabel.font = [UIFont systemFontOfSize:9];
    _badgeLabel.textColor = [UIColor whiteColor];
    _badgeLabel.textAlignment = NSTextAlignmentCenter;
    [badgeContainer addSubview:_badgeLabel];
    
    
    badgeContainer.center = CGPointMake(self.frame.size.width-4, 1);
    [self addSubview:badgeContainer];
    [badgeContainer release];
}

- (void) setBadgeValue:(NSInteger) badgeValue
{
    if (badgeValue >= 0)
    {
        _badgeValue = badgeValue;
        if (badgeValue == 0)
        {
            self.badgeString = @"0";
        }
        else if (badgeValue > 9)
        {
            self.badgeString = @"9+";
        }
        else
        {
            self.badgeString = [NSString stringWithFormat:@"%d", badgeValue];
        }
        self.badgeImageView.hidden = (badgeValue == 0);
        self.badgeLabel.text = _badgeString;
    }
}

@end
