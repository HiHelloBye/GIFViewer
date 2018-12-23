import UIKit
import FLAnimatedImage
import Photos

class PopUpVC: UIViewController {

    @IBOutlet weak var popupImage: FLAnimatedImageView!
    
    var asset:PHAsset = PHAsset()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        let blurEffect = UIBlurEffect(style: .dark)
//        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
//        blurredEffectView.frame = self.view.bounds
//        view.addSubview(blurredEffectView)
//        view.bringSubview(toFront: popupImage)
//        view.addSubview(popupImage)
        
        popupImage.layer.cornerRadius = 5
    
        asset.getURL() { url in
            let data = try? Data(contentsOf: url!)
            let imageData = FLAnimatedImage(animatedGIFData: data)

            self.popupImage.animatedImage = imageData
        }
    }
    
    @IBAction func closePopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
