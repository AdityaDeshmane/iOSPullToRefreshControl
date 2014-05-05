//
//  ADPullToRefreshView.m
//  ADPullToRefrehControl
//
//  Created by Aditya Deshmane on 05/05/14.
//  Copyright (c) 2014 Aditya Deshmane. All rights reserved.
//

#import "ADPullToRefreshView.h"

#define STRING_IDLE_STATE @"Pull down to refresh..."
#define STRING_DRAG_DOWN_IN_PROGRESS @"Release to refresh..."
#define STRING_DRAGGING_FINISHED @"Refreshing..."
#define DRAG_HEIGHT 60

enum State
{
    IDLE, //or not dragged till sufficient point
    DRAGGED_TILL_SUFFICIENT_POINT_TO_REFRESH,
    REFRESHING
};

@interface ADPullToRefreshView()
{
    UIActivityIndicatorView *activityView;
    UILabel *lblTextInfo;
    UIImageView *imageViewArrow;
    int currentState;
    BOOL isNetWorkReachable;
}

@end

@implementation ADPullToRefreshView

-(id) initWithTableOrCollectionView:(UIView*)tableOrCollectionView andCustomWidth:(int)customWidth
{
    //use custom width only for ipad
    int width = customWidth > 0 ? customWidth : tableOrCollectionView.frame.size.width;
    
    CGRect frame = CGRectMake(0.0f, 0.0f - tableOrCollectionView.bounds.size.height, width, tableOrCollectionView.bounds.size.height);
    
    self = [super initWithFrame:frame];
    
    if (self)
    {
        UIColor *themeColor = [UIColor colorWithRed:(0/255.f) green:(112/255.f) blue:(180/255.f) alpha:1];//0 112 180
        
        //1. View setup
        self.backgroundColor = [UIColor clearColor];
        currentState = IDLE;
        
        //2. Info label setup
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 21.0f, self.frame.size.width, 20.0f)];
        label.text = STRING_IDLE_STATE;
        label.font = [UIFont systemFontOfSize:12.0f];
        label.textColor = themeColor;
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        lblTextInfo = label;
        
        //3. ImageView setup
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width/2 - 80.0f, frame.size.height - 20.0f, 11, 16)];
        [arrowImageView setImage:[UIImage imageNamed:@"DownArrow"]];
        imageViewArrow = arrowImageView;
        [self addSubview:arrowImageView];
        
        //4. Activity indicator setup
        UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		view.frame = CGRectMake((self.frame.size.width/2) - 10 , frame.size.height - 45.0f, 20.0f, 20.0f);
        view.color = themeColor;
		[self addSubview:view];
        activityView = view;
        
        //5. Keep Updating this flag on network status change
        isNetWorkReachable = YES;
    }
    
    return self;
}

- (void)dragging;
{
    UIScrollView *scrollView = (UIScrollView*)self.superview;
    
    
    lblTextInfo.hidden = !isNetWorkReachable;
    imageViewArrow.hidden = !isNetWorkReachable || currentState == REFRESHING;
    
    
    if(scrollView.contentOffset.y < -(DRAG_HEIGHT + 5) && currentState == IDLE && isNetWorkReachable)
    {
        lblTextInfo.text = STRING_DRAG_DOWN_IN_PROGRESS;
        currentState = DRAGGED_TILL_SUFFICIENT_POINT_TO_REFRESH;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        
        imageViewArrow.transform = CGAffineTransformMakeRotation(M_PI);
        [UIView commitAnimations];
    }
}

-(BOOL) isDraggedBeyondRefreshHeight;
{
    UIScrollView *scrollView = (UIScrollView*)self.superview;
    
    if(currentState == DRAGGED_TILL_SUFFICIENT_POINT_TO_REFRESH && isNetWorkReachable)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        scrollView.contentInset = UIEdgeInsetsMake(DRAG_HEIGHT, 0.0f, 0.0f, 0.0f);
        [UIView commitAnimations];
        
        [activityView startAnimating];
        lblTextInfo.text = STRING_DRAGGING_FINISHED;
        currentState = REFRESHING;
        
        imageViewArrow.hidden = YES;
        imageViewArrow.transform = CGAffineTransformMakeRotation(0);
        
        return YES;
    }
    
    return NO;
}

-(void)finishedRefreshing
{
    if(currentState == REFRESHING)
    {
        UIScrollView *tableView = (UIScrollView*)self.superview;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.3];
        [tableView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
        [UIView commitAnimations];
        
        [activityView stopAnimating];
        lblTextInfo.text = STRING_IDLE_STATE;
        currentState = IDLE;
        
        imageViewArrow.hidden = NO;
    }
}

@end
