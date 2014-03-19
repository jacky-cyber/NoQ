//
//  HomePageViewController.m
//  NoQ
//
//  Created by Xiaoxuan Tang on 3/14/14.
//  Copyright (c) 2014 Massvig Ltd.,Co, Shanghai. All rights reserved.
//

#import "HomePageViewController.h"
#import "BadgeButton.h"
#import "HomePageTableViewCell.h"

@interface HomePageViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>
// navigation bar items
@property (nonatomic, retain) IBOutlet UITextField *naviSearchTF;
@property (nonatomic, retain) IBOutlet BadgeButton *naviMsgBtn;
@property (nonatomic, retain) IBOutlet UIView *naviCityView;
// content
@property (nonatomic, retain) IBOutlet UITableView *tableView;

@property (nonatomic, retain) IBOutlet UIView *test;
// for pulling down to share
@property (nonatomic, assign) BOOL pullFromBottom;

@end

@implementation HomePageViewController

- (void) dealloc
{
    SAFE_RELEASE(_naviSearchTF);
    SAFE_RELEASE(_naviMsgBtn);
    SAFE_RELEASE(_naviCityView);
    SAFE_RELEASE(_tableView);
    [super dealloc];
}

- (id) initWithNibName:(NSString *) nibNameOrNil bundle:(NSBundle *) nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self configNavigationBarItem];
    [self configGestures];
    
}

- (void) viewWillAppear:(BOOL) animated
{
    [super viewWillAppear:animated];
    self.tableView.frame = ADJUSTED_VIEW_FRAME;
}

- (void) configNavigationBarItem
{
    self.navigationItem.titleView = self.naviSearchTF;
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:self.naviMsgBtn];
    self.navigationItem.rightBarButtonItem = rightBtn;
    [rightBtn release];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:self.naviCityView];
    self.navigationItem.leftBarButtonItem = leftBtn;
    [leftBtn release];
}

- (void) configGestures
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panResponser:)];
    pan.delegate = self;
    [self.tableView addGestureRecognizer:pan];
    [pan release];
}

- (void) panResponser:(UIPanGestureRecognizer *) pg
{
    NSLog(@"1");
}

- (IBAction) onClickCityBtn:(id) sender
{
    NSLog(@"on click city");
}

#pragma mark - UIGestureDelegate

- (BOOL) gestureRecognizerShouldBegin:(UIGestureRecognizer *) gestureRecognizer
{
    return self.pullFromBottom;
}


#pragma mark - UITableViewDelegate
- (CGFloat) tableView:(UITableView *) tableView heightForRowAtIndexPath:(NSIndexPath *) indexPath
{
    switch (indexPath.section)
    {
        case 0:
            return indexPath.row==0 ? 140 : 175;
        case 1:
            return 174;
        case 2:
            return 266;
        case 3:
            return 58;
        default:
            return 0;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *) tableView
{
    return 4;
}

- (NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger) section
{
    switch (section)
    {
        case 0:
            return 2;
        default:
            return 1;
    }
}

- (UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"HomePageCell_%d_%d", indexPath.section, indexPath.row];
    HomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        NSInteger index = [self indexFromIndexPath:indexPath];
        NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:@"HomePageTableViewCell" owner:nil options:nil];
        cell = xibs[index];
        [cell initLayers];
    }
    [cell showLayers];
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void) scrollViewWillBeginDragging:(UIScrollView *) scrollView
{
    [self.naviSearchTF resignFirstResponder];
    NSLog(@"begin dragging");
//    if (scrollView.contentOffset.y+ADJUSTED_VIEW_FRAME.size.height >= scrollView.contentSize.height)
//    {
//        self.pullFromBottom = YES;
//    }
//    else
//    {
//        self.pullFromBottom = NO;
//    }
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *) scrollView
{
    if (scrollView.contentOffset.y+ADJUSTED_VIEW_FRAME.size.height >= scrollView.contentSize.height)
    {
        self.pullFromBottom = YES;
    }
    else
    {
        self.pullFromBottom = NO;
    }
}

- (void) scrollViewDidEndDragging:(UIScrollView *) scrollView willDecelerate:(BOOL) decelerate
{
    NSLog(@"end dragging");
}

- (void) scrollViewDidScroll:(UIScrollView *) scrollView
{
    if (self.pullFromBottom)
    {
        NSLog(@"aaa");
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *) textField
{
    if (textField.text.length > 0)
    {
        [self.naviSearchTF resignFirstResponder];
        return YES;
    }
    return NO;
}

#pragma mark - Helper

- (NSInteger) indexFromIndexPath:(NSIndexPath *) indexPath
{
    switch (indexPath.section)
    {
        case 0:
            return indexPath.row;
        default:
            return indexPath.section + 1;
    }
}


@end
