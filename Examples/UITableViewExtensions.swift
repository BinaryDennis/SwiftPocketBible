public extension UITableView {

    /**
     This method adjustes the height of tableHeaderView and tableFooterView,
     assuming the custom header/footer views are setup using autolayout.

     **Note:** Only call this method if the custom header/footer view has a
     multi-line label.

     **Important** this method should be called in a view controllers
     `viewDidLayoutSubviews` method, like this

     ```
     override func viewDidLayoutSubviews() {
     super.viewDidLayoutSubviews()
     tableView.sizeHeaderAndFooterToFit()
     }
     ```
     */
    public func sizeHeaderAndFooterToFit() {
        if let headerView = self.tableHeaderView {
            let height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
            var headerFrame = headerView.frame

            // If we don't have this check, viewDidLayoutSubviews() will get called
            // repeatedly, thus causing the app to hang
            if height != headerFrame.size.height {
                headerFrame.size.height = height
                headerView.frame = headerFrame
                self.tableHeaderView = headerView
            }
        }

        if let footerView = self.tableFooterView {
            let height = footerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
            var footerFrame = footerView.frame

            // If we don't have this check, viewDidLayoutSubviews() will get called
            // repeatedly, thus causing the app to hang
            if height != footerFrame.size.height {
                footerFrame.size.height = height
                footerView.frame = footerFrame
                self.tableFooterView = footerView
            }
        }
    }
}
