//
//  QuranCloud.swift
//  Tahfez Quran
//
//  Created by Allam on 9/14/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import Foundation

class QuranCloud: QuranDownloader {
    
    private let quranCloudSession: URLSession
    private let quranCloudSessionConfiguration = URLSessionConfiguration.default
    
    init() {
        quranCloudSession = URLSession(configuration: quranCloudSessionConfiguration)
    }
    
    func getSurah(surahNumber: Int, completion: @escaping (Surah?, Error?) -> ()) {
        let surahUrl = QuranAPI.getSurahUrl(surahNumber: surahNumber)
        getObjectFromQuranCloud(with: surahUrl) { (surah, error) in
            completion(surah, error)
        }
    }
    
    func getAyah(NumberInMushaf ayah: Int, completion: @escaping (Ayah?, Error?)->()) {
        let ayahUrl = QuranAPI.getAyahUrl(ayahNumberInMushaf: ayah)
        getObjectFromQuranCloud(with: ayahUrl) { (ayah, error) in
            completion(ayah, error)
        }
    }
    
    
    private func getObjectFromQuranCloud<T:Codable>(with url:URL, completion: @escaping (T?, Error?)->()){
        let urlRequest = URLRequest(url: url)
        let dataTask = quranCloudSession.dataTask(with: urlRequest) {
            [unowned self] (data, response, error) in //unowned self: don't increase reference count by 1
            guard data != nil, error == nil else{
                completion(nil, error)
                return
            }
            do {
                if let dataObject: T = try self.getObject(from: data!){
                    completion(dataObject, nil)
                }
            }catch let error {
                completion(nil, error)
            }
        }
        dataTask.resume()
    }
    
    private func getObject<T:Codable>(from data: Data) throws -> T?{
        if let dataObject = try QuranAPI.getQuranDataObject(from: data){
            let anyObject = try JSONDecoder().decode(T.self, from: dataObject)
            return anyObject
        }
        return nil
    }
    
}
