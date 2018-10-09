//
//  QuranDownloader.swift
//  Tahfez Quran
//
//  Created by Allam on 9/14/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import Foundation

protocol QuranDownloader{
    func getJuz(juzNumber: Int, completion: @escaping (Juz?, Error?)->())
    func getSurah(surahNumber: Int, completion: @escaping (Surah?, Error?)->())
    func getAyah(NumberInMushaf ayah: Int,completion: @escaping (Ayah?, Error?)->())
    func getAyah(Number ayah: Int, inSurah surah: Int, completion: @escaping (Ayah?, Error?)->())
}

extension QuranDownloader{
    func getJuz(juzNumber: Int, completion: @escaping (Juz?, Error?)->()){}
//    func getSurah(surahNumber: Int, completion: @escaping (Surah?, Error?)->()){}
//    func getAyah(NumberInMushaf ayah: Int,completion: @escaping (Ayah?, Error?)->()){}
    func getAyah(Number ayah: Int, inSurah surah: Int, completion: @escaping (Ayah?, Error?)->()){}
}
