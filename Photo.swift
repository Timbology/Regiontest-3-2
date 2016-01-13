import UIKit
import SwiftyJSON

class Photo {
    
    var id: String!
    var title: String!
    var farm: String!
    var secret: String!
    var server: String!
    var imageUrl: String {
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
    }
    
    init(info: JSON) {
        id = info["id"].stringValue
        title = info["title"].stringValue
        farm = info["farm"].stringValue
        secret = info["secret"].stringValue
        server = info["server"].stringValue
    }
    
    
}