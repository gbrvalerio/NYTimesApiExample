//
//  News.swift
//  NyTimesMostPopular
//
//  Created by Gabriel Bezerra Valério on 05/03/18.
//  Copyright © 2018 Particular. All rights reserved.
//

import Foundation

///Api News Model
///{
///  "url": "string",
///  "column": "string",
///  "section": "string",
///  "byline": "string",
///  "title": "string",
///  "abstract": "string",
///  "published_date": "string",
///  "source": "string",
///  "des_facet": {},
///  "org_facet": {},
///  "per_facet": {},
///  "geo_facet": {},
///  "media":[]
///}
struct NewsModel : Decodable {
    
    ///The news url (www.nytimes.com)...
    let url:String
    ///The column this news belongs to (if any)
    let column:String
    ///The section this news belongs to
    let section:NewsSection
    ///The byline of this news (by Author)
    let byline:String
    ///This news title
    let title:String
    ///This news abstract
    let abstract:String
    ///This news publication date. Format: yyyy-MM-dd
    let publishDate:String
    ///This news source
    let source:String
    ///This news description facets.
    let descriptionFacets:[String]
    ///This news organizations facets
    let organizationFacets:[String]
    ///This news persons facets
    let personsFacets:[String]
    ///This news geographyc facets
    let geographycFacets:[String]
    ///This news associated media
    let media:[NewsMediaImageModel]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        self.column = try container.decodeIfPresent(String.self, forKey: .column) ?? ""
        self.section = try container.decodeIfPresent(NewsSection.self, forKey: .section) ?? .all
        self.byline = try container.decodeIfPresent(String.self, forKey: .byline) ?? ""
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.abstract = try container.decodeIfPresent(String.self, forKey: .abstract) ?? ""
        self.publishDate = try container.decodeIfPresent(String.self, forKey: .publishDate) ?? ""
        self.source = try container.decodeIfPresent(String.self, forKey: .source) ?? ""
        self.descriptionFacets = try NewsModel.decode(facet: .descriptionFacets, from: container)
        self.organizationFacets = try NewsModel.decode(facet: .organizationFacets, from: container)
        self.personsFacets = try NewsModel.decode(facet: .personFacets, from: container)
        self.geographycFacets = try NewsModel.decode(facet: .geographycFacets, from: container)
        self.media = (try? container.decode([NewsMediaImageModel].self, forKey: .media)) ?? []
    }
    
    ///Correctly decodes the facets. It can be an array of strings or a string itself. This method provides a safe wrapper for decoding.
    private static func decode(facet:CodingKeys, from container:KeyedDecodingContainer<CodingKeys>) throws -> [String] {
        var decodingError:Error?
        var facets:[String]?
        
        //case when the facets is an array
        do {
            let possibleFacets = try container.decode([String].self, forKey: facet)
            facets = possibleFacets
        } catch let error {
            decodingError = error
        }
        
        //case when the facets is a string
        do {
            let possibleFacet = try container.decode(String.self, forKey: facet)
            if possibleFacet.isEmpty {
                facets = []
            } else {
                facets = [possibleFacet]
            }
        } catch let error {
            decodingError = error
        }
        
        guard facets != nil else {
            throw decodingError!
        }
        
        return facets!
    }
    
    enum CodingKeys : String, CodingKey {
        case url
        case column
        case section
        case byline
        case title
        case abstract
        case publishDate = "published_date"
        case source
        case descriptionFacets = "des_facet"
        case organizationFacets = "org_facet"
        case personFacets = "per_facet"
        case geographycFacets = "geo_facet"
        case media = "media"
    }
    
}
