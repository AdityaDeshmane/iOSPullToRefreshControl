iOSPullToRefreshControl
=======================

Pull to refresh control for UITableView and UICollectionView


##About 

><p>This is simple custom pull to refresh control similar to facebook app's pull to refresh control. 
><p>Basic idea behind this is, both UITableView and UICollectionView extends UIScrollView so just used scrollview's delegate methods to pass scrollview drag events to custom pull to refresh view.

## Where you can use it ?

>You can use it on UITableView and UICollectionView.



How to use it?
-------------

>
* Add following class files to your project 

   >>ADPullToRefreshView.h
   
   >>ADPullToRefreshView.m

>* How to use above classes 
   
   >>Sample code :
   
   ><pre><code>pullToRefreshView =  [[ADPullToRefreshView alloc] initWithTableOrCollectionView:_tableView andCustomWidth:0]; //Create instance of pull to refresh view </code></pre>

  > // Add it as subview of tableview/collection view (no need to worry about what frame to set etc just add as subview, control does it on its own)
   
   ><pre><code> [_tableView addSubview:pullToRefreshView];</code></pre>

 > // Handle scrollview's these 2 delegate methods and call to respective methods of pull to refresh control as follows
   ><pre><code> 
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

</code></pre>
                                                                          
  >// You will need to add your methods here 1. pulledToRefresh - refreshes table/collectionview 2.finishedUpdating - finidhed updating table/collctionview
  
  ><pre><code> 

-(void)finishedUpdating//this method should be called when finished with table data updating
{
    if (pullToRefreshView)
    {
        [pullToRefreshView finishedRefreshing];
    }
}


-(void)pulledToRefresh//this method should be called when table data is to be refreshed..
{
    [self finishedUpdating];
}

</code></pre>

##Other Info : 


><li>Works for : iOS 6 and above</li>

><li>Uses ARC : Yes </li>

><li>Xcode : 4 and above (Developed using 5.0.1)</li>

><li>Base SDK : 7.0 (Setting lower will also work)</li>

><li>Requires storybord/xib ? : Custom control can be used for both</li>




