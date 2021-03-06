//
//  ADPullToRefreshView.h
//  ADPullToRefrehControl
//
//  Created by Aditya Deshmane on 05/05/14.
//  Copyright (c) 2014 Aditya Deshmane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADPullToRefreshView : UIView

-(id) initWithTableOrCollectionView:(UIView*)tableOrCollectionView andCustomWidth:(int)customWidth;
-(void) dragging;
-(BOOL) isDraggedBeyondRefreshHeight;
-(void) finishedRefreshing;

@end
