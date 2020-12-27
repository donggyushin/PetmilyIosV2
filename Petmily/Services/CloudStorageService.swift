//
//  CloudStorageService.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/27.
//

import UIKit
import Firebase

class CloudStorageService {
    static let shared = CloudStorageService()
    let storage = Storage.storage()
    
    
    // MARK: Image 파일들을 클라우드 서버에 비동기적으로 업로드하고, 업로드를 마치면 PhotoModelToUpload 리스트로 반환한다.
    func uploadImageFiles(photos:[PostPhotoModel], completion:@escaping(Error?, String?, Bool, [PhotoModelToUpload]) -> Void) {
        let storageRef = storage.reference()
        let uuid = UUID().uuidString
        let imagesRef = storageRef.child("images/\(uuid).jpg")
        var photosData:[PhotoModelToUpload] = []
        for photo in photos {
            let data = photo.image.jpegData(compressionQuality: 0.6)
            let index = photo.index
            if data != nil {
                let uploadTask = imagesRef.putData(data!, metadata: nil) { (metadata, error) in
                    guard let metadata = metadata else {
                        // An error occured!
                        
                        return completion(nil, "이미지를 클라우드 스토리지에 업로드하던 도중에 에러가 발생하였습니다.", false, photosData)
                    }
                    imagesRef.downloadURL { (url, error) in
                        if let error = error {
                            // An error occured!
                        
                            return completion(error, nil, false, photosData)
                        }
                        guard let downloadUrl = url else {
                            // An error occured!
                            return completion(nil, "이미지참조값을 불러오던 도중에 에러가 발생하였습니다.", false, photosData)
                        }
                        let downloadUrlString = downloadUrl.absoluteString
                        let imageFullPath = imagesRef.fullPath
                        let size = metadata.size
                        let photoData = PhotoModelToUpload(index: index, downloadUrl: downloadUrlString, fullPath: imageFullPath, size: size)
                        photosData.append(photoData)
                        if photosData.count == photos.count {
                            return completion(nil, nil, true, photosData)
                        }
                    }
                }
                uploadTask.resume()
            }
        }
        
    }
    // End of uploadImageFiles
    
}
