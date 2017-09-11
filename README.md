iOSPullToRefreshControl
=======================

Pull to refresh control for UITableView and UICollectionView

![      ](/iOSPullToRefresh.gif "")


## About 

* Works from iOS 7 to 11
* Pull to refresh control similar to facebook app. 
* Although this control is old and iOS provides its default refresh control for table, collection and scrollview. This control can be refered to create your custom pull to refresh as iOS does not provide customisation in default control.
* Basic idea behind this is, both UITableView and UICollectionView extends UIScrollView. So just used scrollview's delegate methods to pass scrollview drag events to custom pull to refresh view.


## Where you can use it ?

You can use it on UITableView, UICollectionView and UIScrollView



How to use it?
-------------

Download DEMO project and go thro files, for details see steps below,

* Add following class files to your project 

<code> 
ADPullToRefreshView.h

ADPullToRefreshView.m
</code>

* How to use above classes 
   
   Sample code :
   
   //1. Create instance of pull to refresh view
   <code>
   pullToRefreshView =  [[ADPullToRefreshView alloc] initWithTableOrCollectionView:_tableView andCustomWidth:0];  
   </code>

  //2. Add above view as subview to table view/collection view (no need to worry about what frame to set etc. just add as subview, control does these sort of handling on its own)
   
   <code>
   [_tableView addSubview:pullToRefreshView];
   </code>

  //3. Handle scrollview's these 2 delegate methods and call to respective methods of pull to refresh control as follows (just copy paste them as it is)
   
 ><pre><code>- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (pullToRefreshView)
    {
        [pullToRefreshView dragging];
    }
}
</code></pre>

 ><pre><code>- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (pullToRefreshView)
    {
        if ([pullToRefreshView isDraggedBeyondRefreshHeight])//when this case is true, means table/collection view was sufficiently dragged. This will show activity indicator with refreshing...text
        {
            [self pulledToRefresh];
        }
    }
}
</code></pre>
                                                                          
  >// You will need to add your methods here 
  
  >1. pulledToRefresh - called to get new data for table/collectionview 
  
  >2. finishedUpdating - when new data received refresh table/collection view content and call this method
  
  
><pre><code>-(void)pulledToRefresh//this method should be called when table data is to be refreshed..
{
    [self finishedUpdating];
}
</code></pre>
  
><pre><code> -(void)finishedUpdating//this method should be called when finished with table data updating
{
    if (pullToRefreshView)
    {
        [pullToRefreshView finishedRefreshing];//this will inform control that refreshing finished, hide control now
    }
}
</code></pre>



##Other Info : 


><li>Works for : iOS 6 and above</li>

><li>Uses ARC : Yes </li>

><li>Xcode : 4 and above (Developed using 5.0.1)</li>

><li>Base SDK : 7.0 (Setting lower will also work)</li>

><li>Requires storybord/xib ? : Custom control can be used for both</li>




