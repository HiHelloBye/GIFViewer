import Photos
import Foundation
import FLAnimatedImage

class PhotoManager{
    var assetFetchResult:PHFetchResult<PHAsset>! = PHFetchResult<PHAsset>()
    
    var images:[FLAnimatedImage] = [FLAnimatedImage()]
    var data:[Data] = [Data()]
    var test:NSMutableArray = NSMutableArray()
    
    func getGif() -> PHFetchResult<PHAsset> {
        if #available(iOS 11.0, *) {
            if let gifCollection = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumAnimated, options: nil).firstObject {
                return PHAsset.fetchAssets(in: gifCollection, options: nil)
            }
        } else {
            // Fallback on earlier versions
        }
        return PHFetchResult<PHAsset>()
    }
    
    func getGif2() {
        if #available(iOS 11.0, *) {
            if let gifCollection = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumAnimated, options: nil).firstObject {
                self.assetFetchResult = PHAsset.fetchAssets(in: gifCollection, options: nil)
            }
        } else {
            // Fallback on earlier versions
        }
        
        for i in 0 ..< self.assetFetchResult.count {
            self.assetFetchResult[i].getURL() { url in
                let imageData = try? Data(contentsOf: url!)
                let imageData2 = FLAnimatedImage(animatedGIFData: imageData, optimalFrameCacheSize: 50, predrawingEnabled: false)
                self.images.append(imageData2!)
            }
        }
    }
}

// to get PHAsset Url
extension PHAsset {
    
    func getURL(completionHandler: @escaping ((_ resonseURL : URL?) -> Void)) {
        if self.mediaType == .image {
            let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
            options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
                return true
            }
            
            self.requestContentEditingInput(with: options, completionHandler: {(
                contentEditingInput: PHContentEditingInput?, info:[AnyHashable: Any]) -> Void in
                completionHandler(contentEditingInput!.fullSizeImageURL as URL?)
            })
        } else if self.mediaType == .video {
            let options:PHVideoRequestOptions = PHVideoRequestOptions()
            options.version = .original
            PHImageManager.default().requestAVAsset(forVideo: self, options: options, resultHandler: {(asset: AVAsset?, audioMix: AVAudioMix?, info: [AnyHashable:Any]?) -> Void in
                if let urlAsset = asset as? AVURLAsset {
                    let localVideoUrl: URL = urlAsset.url as URL
                    completionHandler(localVideoUrl)
                } else {
                    completionHandler(nil)
                }
            })
        }
    }
}
