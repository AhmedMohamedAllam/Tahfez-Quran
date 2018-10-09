//
//  Surah.swift
//  Tahfez Quran
//
//  Created by Allam on 9/13/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import Foundation

class Surah: Codable {
    var number: Int?
    var name: String?
    var numberOfAyahs: Int?
    var englishName: String?
    var englishNameTranslation: String?
    var revelationType: String?
    var ayahs: [Ayah]?
    var beginnigNumber: Int?
    var endingNumber: Int?
    
    init(surahNumber: Int, surahName: String, numberOfAyahs: Int, englishName: String, englishNameTranslation : String, revelationType: String, ayahs: [Ayah]) {
        self.number = surahNumber
        self.name = surahName
        self.numberOfAyahs = numberOfAyahs
        self.englishName = englishName
        self.englishNameTranslation = englishNameTranslation
        self.revelationType = revelationType
        self.ayahs = ayahs
    }
    
    
}
