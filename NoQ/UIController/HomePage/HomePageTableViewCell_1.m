//
//  HomePageTableViewCell_1.m
//  NoQ
//
//  Created by Xiaoxuan Tang on 3/17/14.
//  Copyright (c) 2014 Massvig Ltd.,Co, Shanghai. All rights reserved.
//

#import "HomePageTableViewCell_1.h"
#import "iCarousel.h"

@interface HomePageTableViewCell_1()<iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, retain) IBOutlet iCarousel *slide;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;

@end

@implementation HomePageTableViewCell_1

- (void) dealloc
{
    SAFE_RELEASE(_slide);
    SAFE_RELEASE(_pageControl);
    [super dealloc];
}

- (void) initLayers
{
    [super initLayers];
    self.slide.decelerationRate = 10;
    self.slide.scrollSpeed = 0.5;
    self.slide.bounceDistance = 0.5;
    self.slide.type = iCarouselTypeLinear;
}

- (void) showLayers
{
    [super showLayers];
    self.pageControl.numberOfPages = 2;
}

#pragma mark - iCarousel delegate
- (NSUInteger) numberOfItemsInCarousel:(iCarousel *) carousel
{
    return 2;
}

- (UIView *) carousel:(iCarousel *) carousel viewForItemAtIndex:(NSUInteger) index reusingView:(UIView *) view
{
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 139)];
    }
    NSString *imgName = [NSString stringWithFormat:@"homepage_qa_%d", index+1];
    ((UIImageView *)view).image = IMAGE(imgName);
    return view;
}

- (BOOL) carouselShouldWrap:(iCarousel *) carousel
{
    return YES;
}

- (void) carousel:(iCarousel *) carousel didSelectItemAtIndex:(NSInteger) index
{
    
}

- (void) carouselWillBeginScrollingAnimation:(iCarousel *) carousel
{
    self.pageControl.currentPage = self.slide.currentItemIndex;
}

- (void) carouselDidScroll:(iCarousel *) carousel
{
    self.pageControl.currentPage = self.slide.currentItemIndex;
}

- (void) carouselDidEndScrollingAnimation:(iCarousel *) carousel
{
    self.pageControl.currentPage = self.slide.currentItemIndex;
}

- (IBAction) actionForPageControl:(UIPageControl *) pageControl
{
    [self.slide scrollToItemAtIndex:pageControl.currentPage animated:YES];
}

@end
