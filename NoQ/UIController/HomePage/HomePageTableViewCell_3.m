//
//  HomePageTableViewCell_3.m
//  NoQ
//
//  Created by Xiaoxuan Tang on 3/18/14.
//  Copyright (c) 2014 Massvig Ltd.,Co, Shanghai. All rights reserved.
//

#import "HomePageTableViewCell_3.h"
#import "iCarousel.h"
#import "HomePageTableViewCell_3_Slide.h"

@interface HomePageTableViewCell_3() <iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;
@property (nonatomic, retain) IBOutlet iCarousel *slide;
@property (nonatomic, retain) NSArray *slides;

@end

@implementation HomePageTableViewCell_3

- (void) dealloc
{
    SAFE_RELEASE(_slide);
    SAFE_RELEASE(_slides);
    [super dealloc];
}

- (void) initLayers
{
    [super initLayers];
    
    HomePageTableViewCell_3_Slide *slide1 = [[HomePageTableViewCell_3_Slide alloc] init];
    HomePageTableViewCell_3_Slide *slide2 = [[HomePageTableViewCell_3_Slide alloc] init];
    HomePageTableViewCell_3_Slide *slide3 = [[HomePageTableViewCell_3_Slide alloc] init];
    self.slides = @[slide1, slide2, slide3];
    [slide3 release];
    [slide2 release];
    [slide1 release];
    
    self.slide.decelerationRate = 10;
    self.slide.scrollSpeed = 0.5;
    self.slide.bounceDistance = 0.5;
    self.slide.type = iCarouselTypeLinear;
}

- (void) showLayers
{
    [super showLayers];
    self.pageControl.numberOfPages = self.slides.count;
    [self.slide reloadData];
}

#pragma mark - iCarousel delegate
- (NSUInteger) numberOfItemsInCarousel:(iCarousel *) carousel
{
    return [self.slides count];
}

- (UIView *) carousel:(iCarousel *) carousel viewForItemAtIndex:(NSUInteger) index reusingView:(UIView *) view
{
    return self.slides[index];
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

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return 320;
}

@end
