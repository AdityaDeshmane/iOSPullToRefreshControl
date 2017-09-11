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

**STEP1:** Add following class files to your project 

```
ADPullToRefreshView.h

ADPullToRefreshView.m
```
      
**STEP 2:** Create instance of pull to refresh view
  
``` 
pullToRefreshView =  [[ADPullToRefreshView alloc] initWithTableOrCollectionView:_tableView andCustomWidth:0];  

```
   
**STEP 3:** Add above view as subview to table view/collection view (no need to worry about what frame to set etc. just add as subview, control does these sort of handling on its own)
   
 ```
 [_tableView addSubview:pullToRefreshView];
 ```

**STEP 4:** Handle scrollview's following two delegate methods and call refresh control methods as follows (just copy paste them as it is)
   
```
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (pullToRefreshView)//nil check
    {
        [pullToRefreshView dragging];//dragging down is in progress
    }
}
```

```
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (pullToRefreshView)//nil check
    {
        if ([pullToRefreshView isDraggedBeyondRefreshHeight])//when this case is true, means table/collection view was sufficiently dragged. This will show activity indicator with refreshing...text
        {
            //Get table data from Web Service etc. 
        }
    }
}
```
                                                                          
Once you are done with fetching table content data from Web Service etc. call method ```finishedRefreshing``` to hide pull to refresh control

  
```

    
   [pullToRefreshView finishedRefreshing];//this will inform control that refreshing finished, hide control now
   

```






