import Foundation
import Photos

extension Downloader {

    func getAlbum(completion: @escaping (PHAssetCollection?, Error?) -> Void) {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", "InstaP4tch0")
        let fetchResult = 
        PHAssetCollection.fetchAssetCollections(with: .album, 
                                                subtype: .albumRegular, 
                                                options: fetchOptions)
        guard let album = fetchResult.firstObject else {
            var albumPlaceholder: PHObjectPlaceholder?
            return PHPhotoLibrary.shared().performChanges({
                let request = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: "InstaP4tch0")
                albumPlaceholder = request.placeholderForCreatedAssetCollection
            }, completionHandler: { success, error in
                guard success else {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                    return
                }
                guard let ap = albumPlaceholder else {
                    DispatchQueue.main.async {
                        completion(nil, nil)
                    }
                    return
                }
                let fetchResult = 
                PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [ap.localIdentifier], options: nil)
                DispatchQueue.main.async {
                    completion(fetchResult.firstObject, nil)
                }
                return
            })
        }
        completion(album, nil)
    }

    func save(image: UIImage, completion: @escaping (Error?) -> Void) {
        getAlbum { album, error in
            guard let album = album else {
                return completion(error)
            }
            PHPhotoLibrary.shared().performChanges({
                let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
                let assetPlaceholder = assetChangeRequest.placeholderForCreatedAsset
                let albumChangeRequest = PHAssetCollectionChangeRequest(for: album)
                guard let ap = assetPlaceholder else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                albumChangeRequest?.addAssets([ap] as NSArray)
            }, completionHandler: { success, error in
                DispatchQueue.main.async {
                    completion(error)
                }
            })
        }
    }

}
