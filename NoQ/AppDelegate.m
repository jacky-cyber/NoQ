//
//  AppDelegate.m
//  NoQ
//
//  Created by Xiaoxuan Tang on 3/14/14.
//  Copyright (c) 2014 Massvig Ltd.,Co, Shanghai. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabbarController.h"
#import "BaseNavigationController.h"
#import "HomePageViewController.h"
#import "CardBagViewController.h"
#import "UserCentreViewController.h"
#import "MoreViewController.h"


@implementation AppDelegate

- (void) dealloc
{
    [super dealloc];
    SAFE_RELEASE(_window);
    SAFE_RELEASE(_rootViewController);
}

- (BOOL) application:(UIApplication *) application didFinishLaunchingWithOptions:(NSDictionary *) launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.rootViewController = [self customizedTabbarController];
    self.window.rootViewController = self.rootViewController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (BaseTabbarController *) customizedTabbarController
{
    BaseTabbarController *tbrCtrl = [[BaseTabbarController alloc] init];
    tbrCtrl.viewControllers = [self arrayOfViewControllers];
    if (DEVICE_VERSION >= 7)
    {
        tbrCtrl.tabBar.tintColor = COLOR(250, 93, 59);
    }
    return [tbrCtrl autorelease];
}

- (NSArray *) arrayOfViewControllers
{
    NSArray *imageNormalArr, *imageSelectedArr, *titleArr;
    if (DEVICE_VERSION >= 7)
    {
        imageNormalArr = @[@"tabbar_1_normal", @"tabbar_2_normal", @"tabbar_3_normal", @"tabbar_4_normal"];
        imageSelectedArr = @[@"tabbar_1_selected", @"tabbar_2_selected", @"tabbar_3_selected", @"tabbar_4_selected"];
        titleArr = @[@"首页", @"卡包", @"我的", @"更多"];
    }
    else
    {
        imageNormalArr = @[@"tabbar_1_normal_full", @"tabbar_2_normal_full", @"tabbar_3_normal_full", @"tabbar_4_normal_full"];
        imageSelectedArr = @[@"tabbar_1_selected_full", @"tabbar_2_selected_full", @"tabbar_3_selected_full", @"tabbar_4_selected_full"];
        titleArr = @[@"", @"", @"", @""];
    }
    
    HomePageViewController *hpCtrl = [[[HomePageViewController alloc] initWithNibName:@"HomePageViewController" bundle:nil] autorelease];
    BaseNavigationController *navi1 = [[[BaseNavigationController alloc] initWithRootViewController:hpCtrl] autorelease];
    UITabBarItem *hpItem = [[[UITabBarItem alloc] initWithTitle:titleArr[0] image:TABBAR_IMAGE(imageNormalArr[0]) tag:1] autorelease];
    hpItem.selectedImage = TABBAR_IMAGE(imageSelectedArr[0]);
    navi1.tabBarItem = hpItem;
    
    CardBagViewController *cbCtrl = [[[CardBagViewController alloc] initWithNibName:@"CardBagViewController" bundle:nil] autorelease];
    BaseNavigationController *navi2 = [[[BaseNavigationController alloc] initWithRootViewController:cbCtrl] autorelease];
    UITabBarItem *cbItem = [[[UITabBarItem alloc] initWithTitle:titleArr[1] image:TABBAR_IMAGE(imageNormalArr[1]) tag:2] autorelease];
    cbItem.selectedImage = TABBAR_IMAGE(imageSelectedArr[1]);
    navi2.tabBarItem = cbItem;
    
    UserCentreViewController *ucCtrl = [[[UserCentreViewController alloc] initWithNibName:@"UserCentreViewController" bundle:nil] autorelease];
    BaseNavigationController *navi3 = [[[BaseNavigationController alloc] initWithRootViewController:ucCtrl] autorelease];
    UITabBarItem *ucItem = [[[UITabBarItem alloc] initWithTitle:titleArr[2] image:TABBAR_IMAGE(imageNormalArr[2]) tag:3] autorelease];
    ucItem.selectedImage = TABBAR_IMAGE(imageSelectedArr[2]);
    navi3.tabBarItem = ucItem;
    
    MoreViewController *mCtrl = [[[MoreViewController alloc] initWithNibName:@"MoreViewController" bundle:nil] autorelease];
    BaseNavigationController *navi4 = [[[BaseNavigationController alloc] initWithRootViewController:mCtrl] autorelease];
    UITabBarItem *mItem = [[[UITabBarItem alloc] initWithTitle:titleArr[3] image:TABBAR_IMAGE(imageNormalArr[3]) tag:4] autorelease];
    mItem.selectedImage = TABBAR_IMAGE(imageSelectedArr[3]);
    navi4.tabBarItem = mItem;
    
    NSArray *ctrls = @[navi1, navi2, navi3, navi4];
    return ctrls;
}

- (void) applicationWillResignActive:(UIApplication *) application
{
}

- (void) applicationDidEnterBackground:(UIApplication *) application
{
}

- (void) applicationWillEnterForeground:(UIApplication *) application
{
}

- (void) applicationDidBecomeActive:(UIApplication *) application
{
}

- (void) applicationWillTerminate:(UIApplication *) application
{
}

@end
