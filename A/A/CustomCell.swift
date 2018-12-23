import UIKit
import PinterestLayout
import FLAnimatedImage

class CustomCell: UICollectionViewCell {
    
    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    var representedAssetIdentifier: String = ""
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? PinterestLayoutAttributes {
            //change image view height by changing its constraint
            imageViewHeightConstraint.constant = attributes.imageHeight
        }
    }
}
