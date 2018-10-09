//
//  Fehres.swift
//  Tahfez Quran
//
//  Created by Allam on 10/9/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import Foundation

/*
 *
 */
/// Language Description
enum Language: String{
    /// romanized Description
    /// - romanized: names in arabic but written in english letters (franco) e.g, Al-Fatiha
    case arabic = "ar"
    case english = "en"
    case romanized = "romanized"
}

struct Fehres {
    private static func getSurahsNamesJsonData() -> Data? {
        if let surasNamesPath = Bundle.main.path(forResource: "surahs_names", ofType: "txt"){
            do{
                let surahsNames = try String(contentsOfFile: surasNamesPath, encoding: .utf8)
                let jsonData = surahsNames.data(using: .utf8)
                return jsonData
            }catch let error{
                print("couldn't read surahs names because of : \(error)")
            }
        }
        return nil
    }
    
    static func getSurahsNames(for language: Language) -> [String]? {
        if let data = getSurahsNamesJsonData(){
            do{
                if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String:[String]]{
                    let arabicNames = jsonObject[language.rawValue]
                    return arabicNames
                }
            }catch let error{
                print(error)
            }
        }
        return nil
    }
}
