//
//  UINavigationItem+margin.m
//  NoQ
//
//  Created by Xiaoxuan Tang on 3/14/14.
//  Copyright (c) 2014 Massvig Ltd.,Co, Shanghai. All rights reserved.
//

#import "UINavigationItem+margin.h"

@implementation UINavigationItem (margin)

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1

//- (void) setLeftBarButtonItem:(UIBarButtonItem *) _leftBarButtonItem
//{
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
//    {
//        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//        negativeSeperator.width = -12;
//        
//        if (_leftBarButtonItem)
//        {
//            [self setLeftBarButtonItems:@[negativeSeperator, _leftBarButtonItem]];
//        }
//        else
//        {
//            [self setLeftBarButtonItems:@[negativeSeperator]];
//        }
//        [negativeSeperator release];
//    }
//    else
//    {
//        [self setLeftBarButtonItem:_leftBarButtonItem animated:NO];
//    }
//}
//
//- (void) setRightBarButtonItem:(UIBarButtonItem *) _rightBarButtonItem
//{
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
//    {
//        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//        negativeSeperator.width = -12;
//        
//        if (_rightBarButtonItem)
//        {
//            [self setRightBarButtonItems:@[negativeSeperator, _rightBarButtonItem]];
//        }
//        else
//        {
//            [self setRightBarButtonItems:@[negativeSeperator]];
//        }
//        [negativeSeperator release];
//    }
//    else
//    {
//        [self setRightBarButtonItem:_rightBarButtonItem animated:NO];
//    }
//}

#endif

@end
