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

typedef enum
{
    PD_Default = 0,
    PD_AllowPullDown = 1,
    PD_PullingDown = 3,
    PD_Hidding = 7,
} PullingDownState;

@interface HomePageViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>
// navigation bar items
@property (nonatomic, retain) IBOutlet UITextField *naviSearchTF;
@property (nonatomic, retain) IBOutlet BadgeButton *naviMsgBtn;
@property (nonatomic, retain) IBOutlet UIView *naviCityView;
// content
@property (nonatomic, retain) IBOutlet UITableView *tableView;

@property (nonatomic, retain) IBOutlet UIView *sharingView;
// for pulling down to share
@property (nonatomic, assign) PullingDownState state;

@end

@implementation HomePageViewController

- (void) dealloc
{
    SAFE_RELEASE(_sharingView);
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
        _state = PD_Default;
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self configNavigationBarItem];
    [self configGesture];
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

- (void) configGesture
{
    UIPanGestureRecognizer *pg = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panResponser:)];
    [self.sharingView addGestureRecognizer:pg];
    [pg release];
}

- (void) panResponser:(UIPanGestureRecognizer *) pg
{
    static CGFloat y = 0;
    if (pg.state == UIGestureRecognizerStateBegan)
    {
        y = [pg locationInView:self.sharingView].y;
    }
    else if (pg.state == UIGestureRecognizerStateChanged)
    {
        CGFloat crtY = [pg locationInView:self.sharingView].y;
        CGFloat delta = crtY - y;
        CGRect tableFrame = self.tableView.frame;
        if (delta > 0 && ADJUSTED_VIEW_FRAME.origin.y < tableFrame.origin.y+delta)
        {
            delta = ADJUSTED_VIEW_FRAME.origin.y - tableFrame.origin.y;
        }
        else if (delta < 0 && tableFrame.origin.y + delta < TOP_HIDE_VIEW_FRAME.origin.y)
        {
            delta = TOP_HIDE_VIEW_FRAME.origin.y - tableFrame.origin.y;
        }
        self.tableView.frame = CGRectOffset(tableFrame, 0, delta);
        [self makeScaleViaScrollView:self.tableView timeInterval:0];
        y = crtY;
    }
    else if (pg.state == UIGestureRecognizerStateEnded || pg.state == UIGestureRecognizerStateCancelled)
    {
        [self pullDownDidEndDraggingEffectWithScrollView:self.tableView];
    }
}

- (IBAction) onClickCityBtn:(id) sender
{
    NSLog(@"on click city");
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
    if (scrollView.contentOffset.y + ADJUSTED_VIEW_FRAME.size.height >= scrollView.contentSize.height)
    {
        self.state = PD_AllowPullDown;
    }
}

- (void) scrollViewDidEndDragging:(UIScrollView *) scrollView willDecelerate:(BOOL) decelerate
{
    [self pullDownDidEndDraggingEffectWithScrollView:scrollView];
}

- (void) scrollViewDidScroll:(UIScrollView *) scrollView
{
    CGFloat delta = scrollView.contentOffset.y + ADJUSTED_VIEW_FRAME.size.height - scrollView.contentSize.height;
    if (delta > 0)
    {
        [self pullDownEffectWithDelta:-delta scrollView:scrollView];
    }
    else
    {
        CGFloat delta_2 = ADJUSTED_VIEW_FRAME.origin.y - scrollView.frame.origin.y;
        if (delta_2 > 0)
        {
            if (-delta < delta_2)
            {
                [self pullDownEffectWithDelta:-delta scrollView:scrollView];
            }
            else
            {
                [self pullDownEffectWithDelta:delta_2 scrollView:scrollView];
            }
        }
        else if (delta_2 < 0)
        {
            if (self.state == PD_AllowPullDown)
            {
                self.state = PD_Default;
            }
        }
    }
}

#pragma mark - Helper

- (void) pullDownEffectWithDelta:(CGFloat) delta scrollView:(UIScrollView *) scrollView
{
    if (self.state & PD_AllowPullDown)
    {
        [scrollView setContentOffset:CGPointMake(0, scrollView.contentSize.height - ADJUSTED_VIEW_FRAME.size.height)];
        if (scrollView.frame.origin.y + delta == ADJUSTED_VIEW_FRAME.origin.y)
        {
            [scrollView setFrame:ADJUSTED_VIEW_FRAME];
        }
        else
        {
            [scrollView setFrame:CGRectOffset(scrollView.frame, 0, delta)];
            
            [self makeScaleViaScrollView:scrollView timeInterval:0];
        }
    }
}

- (void) pullDownDidEndDraggingEffectWithScrollView:(UIScrollView *) scrollView
{
    CGFloat delta = ADJUSTED_VIEW_FRAME.origin.y - scrollView.frame.origin.y;
    // pulling down
    if (delta > 0)
    {
        // reset to bottom
        if (delta < ADJUSTED_VIEW_FRAME.size.height/2)
        {
            self.state = PD_PullingDown;
            [UIView animateWithDuration:0.5 animations:^{
                [scrollView setFrame:ADJUSTED_VIEW_FRAME];
            } completion:^(BOOL finished) {
                self.state = PD_AllowPullDown;
            }];
        }
        // hide
        else
        {
            self.state = PD_PullingDown;
            [UIView animateWithDuration:0.5 animations:^{
                [scrollView setFrame:CGRectOffset(ADJUSTED_VIEW_FRAME, 0, -ADJUSTED_VIEW_FRAME.size.height)];
            } completion:^(BOOL finished) {
                self.state = PD_Hidding;
            }];
        }
        [self makeScaleViaScrollView:scrollView timeInterval:0.5];
    }
    else
    {
        if (scrollView.contentOffset.y + ADJUSTED_VIEW_FRAME.size.height < scrollView.contentSize.height)
        {
            self.state = PD_Default;
        }
    }
}

- (void) makeScaleViaScrollView:(UIScrollView *) scrollView timeInterval:(NSTimeInterval) timeInterval
{
    CGFloat scaleRatio = [self calculateScaleRatioViaScrollView:scrollView];
    [UIView animateWithDuration:timeInterval animations:^{
        self.sharingView.transform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
    }];
}
- (CGFloat) calculateScaleRatioViaScrollView:(UIScrollView *) scrollView
{
    return 1 - (scrollView.frame.origin.y - TOP_HIDE_VIEW_FRAME.origin.y) / (ADJUSTED_VIEW_FRAME.origin.y - TOP_HIDE_VIEW_FRAME.origin.y) * 0.2;
}

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
