//
//  DisplayQuranViewController.swift
//  Tahfez Quran
//
//  Created by Allam on 10/9/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import UIKit

class DisplayQuranViewController: UIViewController {
    
    @IBOutlet weak var surahNameTextView: UITextView!
    @IBOutlet weak var quranTextView: UITextView!
    
    var surah:Surah?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView(with: surah)
    }
    
    
    
    
    private func updateView(with surah: Surah?){
        if let surah = surah{
            self.surahNameTextView.text = surah.name!
            self.quranTextView.text = self.concatenateAyahsText(from: surah.ayahs!)
        }
    }
    
    private func concatenateAyahsText(from ayahs:[Ayah]) -> String{
        var text = configureBesmEllahAyah(firstAyah: ayahs[0])
        
        for i in 1..<ayahs.count{
            let ayah = ayahs[i]
            text +=  ayah.text! + " (\(ayah.numberInSurah!)) "
        }
        return text
    }
    
    private func configureBesmEllahAyah(firstAyah ayah: Ayah) -> String{
        let besmellahAyahCharsCount = 22
        var text = ""
        if let ayahText = ayah.text{
            if ayahText.count > besmellahAyahCharsCount{
                let besmellah = ayahText.prefix(besmellahAyahCharsCount)
                let remainingAyah = ayahText.dropFirst(besmellahAyahCharsCount + 1) // +1 for the space
                text = besmellah + "\n" + remainingAyah + " (\(ayah.numberInSurah!)) "
            }else{
                text += ayahText + " (\(ayah.numberInSurah!)) \n"
            }
        }
        return text
    }
    
}
