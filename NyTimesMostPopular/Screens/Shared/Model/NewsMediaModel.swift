//
//  NewsMediaModel.swift
//  NyTimesMostPopular
//
//  Created by Gabriel Bezerra Valério on 05/03/18.
//  Copyright © 2018 Particular. All rights reserved.
//

import Foundation

static let kNewsMediaImageType = "image"

///The news media model
///Format:
///{
///"type": "string",
///"subtype": "string",
///"caption": "string",
///"copyright": "string",
///"approved_for_syndication": number,
///"media-metadata": []
///}
struct NewsMediaImageModel : Decodable {
    ///The type of the media. Currently supporting only 'image'
    let type:String
    ///The subtype of the image.
    let subtype:String
    ///The caption of the image
    let caption:String
    ///The copyright of the image
    let copyright:String
    ///The metadata of this image
    let metadata:[NewsMediaMetadataImageModel]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        self.subtype = try container.decodeIfPresent(String.self, forKey: .subtype) ?? ""
        self.caption = try container.decodeIfPresent(String.self, forKey: .caption) ?? ""
        self.copyright = try container.decodeIfPresent(String.self, forKey: .copyright) ?? ""
        self.metadata = try container.decodeIfPresent([NewsMediaMetadataImageModel].self, forKey: .metadata) ?? []
    }
    
    private enum CodingKeys : String, CodingKey {
        case type
        case subtype
        case caption
        case copyright
        case metadata = "media-metadata"
    }
}

///  {
///    "url": "string",
///    "format": "string",
///    "height": number,
///    "width": number
///  }
struct NewsMediaMetadataImageModel : Decodable {
    
    ///The image url
    let url:String
    ///The image format (thumbnail, format by size).
    let format:NewsMediaMetadataImageModelFormat
    ///The image height
    let height:Int
    ///The image width
    let width:Int
    
}

///All the supported image formats by the NYTimes api
enum NewsMediaMetadataImageModelFormat : String, Decodable {
    case thumbnail = "Standard Thumbnail"
    case medium210 = "mediumThreeByTwo210"
    case medium440 = "mediumThreeByTwo440"
}
