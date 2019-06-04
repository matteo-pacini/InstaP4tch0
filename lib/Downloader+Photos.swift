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

    func save(post: PostType, with url: URL, completion: @escaping (Error?) -> Void) {
        getAlbum { album, error in
            guard let album = album else {
                return completion(error)
            }
            PHPhotoLibrary.shared().performChanges({
                guard let assetChangeRequest = post.assetChangeRequest(with: url),
                      let assetPlaceholder = assetChangeRequest.placeholderForCreatedAsset else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                let albumChangeRequest = PHAssetCollectionChangeRequest(for: album)
                albumChangeRequest?.addAssets([assetPlaceholder] as NSArray)
            }, completionHandler: { success, error in
                DispatchQueue.main.async {
                    completion(error)
                }
            })
        }
    }

}

private extension PostType {

    func assetChangeRequest(with url: URL) -> PHAssetChangeRequest? {
        switch self {
            case .photo: return PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: url)
            case .video: return PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
            default: return nil
        }
    }

}