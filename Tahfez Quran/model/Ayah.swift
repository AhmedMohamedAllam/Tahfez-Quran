//
//  Ayah.swift
//  Tahfez Quran
//
//  Created by Allam on 9/13/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import Foundation

class Ayah: Codable {
    var hizbQuarter:Int?
    var juz: Int?
    var manzil: Int?
    var number: Int?
    var numberInSurah: Int?
    var page: Int?
    var ruku: Int?
    var text:String?
    
    init(hizbQuarter:Int, juz: Int ,manzil: Int ,number: Int ,numberInSurah: Int ,page: Int ,ruku: Int, text: String) {
        self.hizbQuarter = hizbQuarter
        self.juz = juz
        self.manzil = manzil
        self.number = number
        self.numberInSurah = numberInSurah
        self.page = page
        self.ruku = ruku
        self.text = text
    }
}
