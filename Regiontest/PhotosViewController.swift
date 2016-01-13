import UIKit
import Alamofire

class PhotosViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    
    var photos = [Photo]!()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadImage(photos[5].imageUrl) { (image) -> Void in
            self.image.image = image
        }
        
        
        
    }
    
    
    func downloadImage(url: String, completion: (image: UIImage) -> Void) {
        Alamofire.request(.GET, url).response { _, _, data, _ in
            if let data = data {
                let image = UIImage(data: data)
                completion(image: image!)
            }
        }
    }
}







