//
//  QuranAPI.swift
//  Tahfez Quran
//
//  Created by Allam on 9/13/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import Foundation

enum Mushaf: String {
    case Juz = "juz"
    case Surah = "surah"
    case Ayah = "ayah"
}

struct QuranAPI {
    private static let baseUrl = "http://api.alquran.cloud"
    private static let defaultQuranEdition = "quran-uthmani"
    
    // MARK:- URL methods for Juz, Surah and Ayah
    static func getJuzUrl(juzNumber : Int, quranEdition: String = defaultQuranEdition, offsetAyahNumber offset: Int? = nil, limitAyahsCount limit: Int? = nil) -> URL{
        var juzUrl = getBaseUrlWithParams(quranEdition: quranEdition, offsetAyahNumber: offset, limitAyahsCount: limit)
        
        let urlPaths = [Mushaf.Juz.rawValue, String(juzNumber), quranEdition]
        juzUrl = appendCustomPathComponent(to: juzUrl, with: urlPaths)
        return juzUrl
    }
    
    static func getSurahUrl(surahNumber : Int, quranEdition: String = defaultQuranEdition, offsetAyahNumber offset: Int? = nil, limitAyahsCount limit: Int? = nil) -> URL{
        var surahUrl = getBaseUrlWithParams(quranEdition: quranEdition, offsetAyahNumber: offset, limitAyahsCount: limit)
        let urlPaths = [Mushaf.Surah.rawValue, String(surahNumber), quranEdition]
        surahUrl = appendCustomPathComponent(to: surahUrl, with: urlPaths)
        return surahUrl
    }
    
    static func getAyahUrl(ayahNumberInMushaf : Int, quranEdition: String = defaultQuranEdition) -> URL{
        var ayahUrl = getBaseUrlWithParams(quranEdition: quranEdition)
        let urlPaths = [Mushaf.Ayah.rawValue, String(ayahNumberInMushaf), quranEdition]
        ayahUrl = appendCustomPathComponent(to: ayahUrl, with: urlPaths)
        return ayahUrl
    }
    
    static func getAyahUrl(ayahNumber number : Int,inSurah surah: Int ,quranEdition: String = defaultQuranEdition) -> URL{
        var ayahUrl = getBaseUrlWithParams(quranEdition: quranEdition)
        let urlPaths = [Mushaf.Ayah.rawValue, "\(surah):\(number)", quranEdition]
        ayahUrl = appendCustomPathComponent(to: ayahUrl, with: urlPaths)
        return ayahUrl
    }
    
    
    // MARK:- Private Helper Methods
    private static func getBaseUrlWithParams(quranEdition: String = defaultQuranEdition, offsetAyahNumber offset: Int? = nil, limitAyahsCount limit: Int? = nil) -> URL {
        
        var urlComponent = URLComponents(string: baseUrl)!
        var queryItems : [URLQueryItem]?
        
        if let offset = offset, let limit = limit{
            let juzParams = ["offset": offset, "limit": limit]
            queryItems = createQueryItems(from: juzParams)
        }
        urlComponent.queryItems = queryItems
        return urlComponent.url!
    }
    
    private static func createQueryItems(from queryDict : [String: Any]?) -> [URLQueryItem]?{
        var queryItems: [URLQueryItem]? = nil
        if let queryDict = queryDict{
            queryItems = [URLQueryItem]()
            for (name, value) in queryDict{
                if let value = value as? String{
                    let tempQueryItem = URLQueryItem(name: name, value: value)
                    queryItems!.append(tempQueryItem)
                }
            }
        }
        return queryItems
    }
    
    private static func appendCustomPathComponent(to url: URL, with paths: [String]) -> URL{
        var urlWithPaths = url
        for path in paths{
            urlWithPaths = urlWithPaths.appendingPathComponent(path)
        }
        return urlWithPaths
    }
    
    // MARK:- Convert Json response to data and vice Versa methods
    
    static func getQuranDataObject(from json: Data) throws -> Data?  {
        let jsonObject = try JSONSerialization.jsonObject(with: json, options: []) as? [String: Any]
        if let json = jsonObject, let dataObjectFromJson = json["data"] as? [String:Any]{
            let data = try JSONSerialization.data(withJSONObject: dataObjectFromJson, options: [])
            return data
        }
        return nil
    }
}
