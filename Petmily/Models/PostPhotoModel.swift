//
//  PostPhotoModel.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/27.
//

import UIKit

struct PostPhotoModel {
    var index:Int
    var image:UIImage
}


struct PhotoModelToUpload {
    // 유저가 선택한 이미지 순서
    var index:Int
    // 해당 이미지를 클라이언트 사이드에서 렌더링해주기 위한 url
    var downloadUrl:String
    // 해당 이미지를 추후에 삭제하기 위한 파일의 경로
    var fullPath:String
    // 해당 업로드되어진 이미지의 사이즈. 참고로, 유저가 올린 사이즈에서 0.6 만큼 컴프레셔됨.
    var size:Int64
}
