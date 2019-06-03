
#import <Foundation/Foundation.h>

@interface IGMainAppHeaderView: UIView
@end

@interface IGFeedItemPhotoCell: UIView
@end

@interface IGFeedItemVideoCell: UIView
@end

@class IGPostItem;
@interface IGFeedItem: NSObject
@property(retain) NSArray<IGPostItem *> *items; 
@end

@class IGVideo;
@class IGPhoto;
@interface IGPostItem: NSObject
@property(readonly, nonatomic) IGVideo *video; 
@property(readonly, nonatomic) IGPhoto *photo; 
@property(readonly, nonatomic) long long mediaType; 
@end

@class IGImageURL;
@interface IGPhoto: NSObject
- (NSArray<IGImageURL *> *)ascendingSizeImageURLs;
@end

@interface IGImageURL: NSObject
@property(readonly, nonatomic) unsigned long long photoImageFlag;
@property(readonly, nonatomic) double height; 
@property(readonly, nonatomic) double width; 
@property(readonly, nonatomic) NSURL *url; 
@end

@interface IGVideo: NSObject
@property(retain, nonatomic) NSArray<NSDictionary *> *videoVersions;
@end
