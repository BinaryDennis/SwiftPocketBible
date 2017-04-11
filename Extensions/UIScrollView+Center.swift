
import Foundation
import UIKit

extension UIScrollView {

    func centerZoomedContent() {
        var width = contentSize.width/2
        width = width - width/zoomScale

        var height = contentSize.height/2
        height = height - height/zoomScale

        contentOffset = CGPoint(x: width, y: height);
    }
}
