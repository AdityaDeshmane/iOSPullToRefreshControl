//
//  ViewController.m
//  ADPullToRefrehControl
//
//  Created by Aditya Deshmane on 05/05/14.
//  Copyright (c) 2014 Aditya Deshmane. All rights reserved.
//

#import "ViewController.h"

#import "ADPullToRefreshView.h"//STEP 1/4: IMPORT

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    ADPullToRefreshView *pullToRefreshView;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

-(void)finishedUpdating;
-(void)pulledToRefresh;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //STEP 2/4: CREATE PULL TO REFRESH VIEW INSTANCE AND ADD IT AS SUBVIEW OF TABLE
    pullToRefreshView =  [[ADPullToRefreshView alloc] initWithTableOrCollectionView:_tableView andCustomWidth:0];
    [_tableView addSubview:pullToRefreshView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark tableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TestCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    return cell;
}


//STEP 3/4: CALL RESPECTIVE METHODS OF CUSTOM PULL TO REFRSH IN SCROLL VIEW DELEGATE METHODS
//NOTE : Table view/ Collection view extends UIScrollView, so just add these 2 delegate methods here
#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (pullToRefreshView)
    {
        [pullToRefreshView dragging];
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (pullToRefreshView)
    {
        if ([pullToRefreshView isDraggedBeyondRefreshHeight])
        {
            [self pulledToRefresh];
        }
    }
}

//STEP 4/4: INFORM REFRESH VIEW WHEN DONE WITH UPDATING DATA, BY CALLING finishedRefreshing
#pragma mark -
#pragma mark DataRefresh Methods

-(void)finishedUpdating//this method should be called when finished with table data updating
{
    if (pullToRefreshView)
    {
        [pullToRefreshView finishedRefreshing];
    }
}


-(void)pulledToRefresh//this method should be called when table data is to be refreshed..
{
    [self performSelector:@selector(finishedUpdating) withObject:nil afterDelay:3];
}


@end
