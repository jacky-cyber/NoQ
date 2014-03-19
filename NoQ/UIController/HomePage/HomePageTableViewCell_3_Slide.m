//
//  HomePageTableViewCell_3_Slide.m
//  NoQ
//
//  Created by Xiaoxuan Tang on 3/18/14.
//  Copyright (c) 2014 Massvig Ltd.,Co, Shanghai. All rights reserved.
//

#import "HomePageTableViewCell_3_Slide.h"

@interface HomePageTableViewCell_3_Slide()

@property (nonatomic, retain) IBOutlet UIImageView *headerIV;
@property (nonatomic, retain) IBOutlet UILabel *restaurantNameLbl;
@property (nonatomic, retain) IBOutlet UILabel *consumptionLbl;
@property (nonatomic, retain) IBOutlet UILabel *recommendationLbl;
@property (nonatomic, retain) IBOutlet UILabel *distanceLbl;
@property (nonatomic, retain) IBOutlet UILabel *addressLbl;


@end

@implementation HomePageTableViewCell_3_Slide

- (void) dealloc
{
    SAFE_RELEASE(_headerIV);
    SAFE_RELEASE(_restaurantNameLbl);
    SAFE_RELEASE(_consumptionLbl);
    SAFE_RELEASE(_recommendationLbl);
    SAFE_RELEASE(_distanceLbl);
    SAFE_RELEASE(_addressLbl);
    [super dealloc];
}

- (id) init
{
    NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:@"HomePageTableViewCell_3_Slide" owner:nil options:nil];
    self = [xibs[0] retain];
    
    return self;
}

@end
