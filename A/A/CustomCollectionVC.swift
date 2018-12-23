import UIKit
import Photos
import FLAnimatedImage
import PinterestLayout
import SideMenu

class CustomCollectionVC: UICollectionViewController {

    var assetFetchResult:PHFetchResult<PHAsset> = PHFetchResult<PHAsset>()
    let photoManager = PhotoManager()

    var images:[UIImage] = [UIImage()]
    var assets:[PHAsset] = [PHAsset()]
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func viewDidLoad() {
        
        images.removeAll()
        assets.removeAll()
        
        super.viewDidLoad()
    
        
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    DispatchQueue.main.async {

                        self.fetchGifs()

                        self.collectionView?.reloadData()
                    }

                } else {}
            })
        }
        
        setupCollectionViewInsets()
        setupLayout()
        setDefaults()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchGifs()
    }
    
    func fetchGifs() {
        self.assetFetchResult = photoManager.getGif()
        
        let imageManager = PHCachingImageManager()

        for i in 0 ..< self.assetFetchResult.count {
            
            let asset = self.assetFetchResult.object(at: i)
            self.assets.append(asset)
            
            imageManager.requestImage(for: asset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFill, options: nil, resultHandler: {
                image, _ in
                self.images.append(image!)
            })
        }
        
    }
    
    private func setupCollectionViewInsets() {
        collectionView!.backgroundColor = .white
        collectionView!.contentInset = UIEdgeInsets(
            top: 1,
            left: 1,
            bottom: 1,
            right: 1
        )
        
        collectionView!.dataSource = self
        collectionView!.delegate   = self
    }
    
    private func setupLayout() {
        let layout: PinterestLayout = {
            if let layout = collectionViewLayout as? PinterestLayout {
                return layout
            }
            let layout = PinterestLayout()
            collectionView?.collectionViewLayout = layout
            
            return layout
        }()
        layout.delegate = self
        layout.cellPadding = 1
        layout.numberOfColumns = 2
    }
    
    /*
     * MARK:SideMenu
     */
    
    fileprivate func setupSideMenu() {
        SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        
        
        //swipe
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        //setup background image
//        SideMenuManager.default.menuAnimationBackgroundColor = UIColor(patternImage: UIImage(named: "")!)
    }
  
    fileprivate func setDefaults() {
        SideMenuManager.default.menuPresentMode = .menuDissolveIn
        SideMenuManager.default.menuBlurEffectStyle = .dark
        
        SideMenuManager.default.menuAnimationFadeStrength = 0.5
        SideMenuManager.default.menuShadowOpacity = 0.8
        SideMenuManager.default.menuAnimationTransformScaleFactor = 200
        SideMenuManager.default.menuWidth = 170
    }
  
    /*end_of_SideMenu*/
}

extension CustomCollectionVC {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        let image = images[indexPath.item]
        cell.imageview.image = image
        
        cell.isSelected = false
        collectionView.deselectItem(at: indexPath, animated: true)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UICollectionViewCell ,let indexPath = self.collectionView?.indexPath(for: cell) {
            let vc   = segue.destination as! PopUpVC
            
            vc.asset = self.assets[indexPath.row]
            print(self.assets[indexPath.row])
        }
    }
}

extension CustomCollectionVC: PinterestLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView,
                        heightForImageAtIndexPath indexPath: IndexPath,
                        withWidth: CGFloat) -> CGFloat {
        
        let image = images[indexPath.item]
        return image.height(forWidth: withWidth)
    }
    
    func collectionView(collectionView: UICollectionView,
                        heightForAnnotationAtIndexPath indexPath: IndexPath,
                        withWidth: CGFloat) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
}

extension CustomCollectionVC: UISideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: UISideMenuNavigationController, animated: Bool) {
        
    }
    func sideMenuDidAppear(menu: UISideMenuNavigationController, animated: Bool) {
        
    }
    func sideMenuWillDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        
    }
    func sideMenuDidDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        
    }
}
