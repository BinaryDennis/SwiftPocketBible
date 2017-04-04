import UIKit

extension UIImageView {
    
    private static let keyCurrentImageUrl = "keyCurrentImageUrl"
    
    ///Asynchronously sets self.image from the image at the received URL
    func setImageFromUrl(_ url: URL) {
        
        //Keep track of the URL for the current/latest image
        layer.setValue(url.absoluteString, forKey: UIImageView.keyCurrentImageUrl)
        
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: url) {
                guard url.absoluteString == self.layer.value(forKey: UIImageView.keyCurrentImageUrl) as! String else {
                    //An old image download has completed - do nothing
                    return
                }
                
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
}
