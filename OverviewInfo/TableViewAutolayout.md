# Auto-layout in TableView's


## iOS6 and prior
In **iOS6** and prior, having a table view with alot of cells, where cells having various/different height, **loading the table view would be slow**.
This because _heightForRowAt:indexPath_, which normally is an "intensive" method, needed to be called to calculate the table view height/content-size.

```swift
func tableView(_ tableView: UITableView, 
               heightForRowAt indexPath: IndexPath) -> CGFloat {
   //return the real height of the cell
}
```

## iOS7 
In **iOS7** a new UITableViewDelegate method was introduced to solve this problem, _estimatedHeightForRowAt:indexPath_.
Now the calculation of table view heigth/content-size could be "estimated" much faster thus the loading of the tableview would be faster.

However, the calcuation of the real height for cells would be *deferred* to later, at so called scroll-time.
So better performance for loading a table and potentially a little less scroll-performance?

```swift
func tableView(_ tableView: UITableView, 
               heightForRowAt indexPath: IndexPath) -> CGFloat {                      
   //return the real height of the cell
}
         
func tableView(_ tableView: UITableView, 
               estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
                        
   //return an estimated best guess of the height that most of the cells will have
   //should be greater than 0 and as close to the real size of the "median" cell
}
```

## iOS8 and above
In **iOS8** the 2 callbacks methods mentioned above can be skipped/ignored/removed and instead you can set the estimated height and row heigth on the table view.

But this requires obviously that all the cells in the table view are auto-layout'ed. So you cannot mix-and-match with cells that are auto-layout'ed and cells that aren't.

Also, this solution "assumes" that all cells are almost equal height. If you have a cell with 3x higher than another cell, you might observe some strange scroll behaviours. In those cases you can also implement the UITableViewDelegate method _estimatedHeightForRowAt:indexPath_ to give a specific estimate for each cell. 



```swift
tableView.estimatedRowHeight = 170.   //should be greater than 0 and as close to the real size of the "median" cell
tableView.rowHeight = UITableViewAutomaticDimension
```

Note that this also applies to section height.

```swift
tableView.estimatedSectionHeaderHeight = 25
tableView.sectionHeaderHeight = UITableViewAutomaticDimension
```


     
