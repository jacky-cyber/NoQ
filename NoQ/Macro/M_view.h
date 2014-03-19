//
//  M_view.h
//  NoQ
//
//  Created by Xiaoxuan Tang on 3/18/14.
//  Copyright (c) 2014 Massvig Ltd.,Co, Shanghai. All rights reserved.
//

#ifndef NoQ_M_view_h
#define NoQ_M_view_h

#define SCREEN_FRAME [[UIScreen mainScreen] bounds]
#define STATUSBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
#define NAVIGATIONBAR_HEIGHT 44
#define TABBAR_HEIGHT 49

#define ADJUSTED_VIEW_FRAME CGRectMake(0, STATUSBAR_HEIGHT+NAVIGATIONBAR_HEIGHT, \
                                       320, SCREEN_FRAME.size.height-STATUSBAR_HEIGHT-NAVIGATIONBAR_HEIGHT-TABBAR_HEIGHT)
#define TOP_HIDE_VIEW_FRAME CGRectOffset(ADJUSTED_VIEW_FRAME, 0, -ADJUSTED_VIEW_FRAME.size.height)

#endif
