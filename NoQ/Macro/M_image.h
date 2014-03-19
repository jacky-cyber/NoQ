//
//  M_image.h
//  NoQ
//
//  Created by Xiaoxuan Tang on 3/14/14.
//  Copyright (c) 2014 Massvig Ltd.,Co, Shanghai. All rights reserved.
//

#import "M_system.h"

#ifndef NoQ_M_image_h
#define NoQ_M_image_h

#define COLOR(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define IMAGE(x) [UIImage imageNamed:x]

#define TABBAR_IMAGE(x) (DEVICE_VERSION>=7)?[[UIImage imageNamed:x] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]:IMAGE(x)

#endif
