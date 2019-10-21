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
            self.quranTextView.attributedText = self.concatenateAyahsText(from: surah.ayahs!)
        }
    }
    
    private func concatenateAyahsText(from ayahs:[Ayah]) -> NSMutableAttributedString{
        var besmellah = ayahs[0].text!.prefix(22)
        if surah?.number == 1{
            besmellah.append(contentsOf: " \u{FD3F}" + "\(getArabicDigitFor(value: 1))" + "\u{FD3E} \n")
        }else{
            besmellah.append(contentsOf: " \n")
        }
//            configureBesmEllahAyah(firstAyah: ayahs[0])
       
        let attributedString = NSMutableAttributedString(string: String(besmellah),
                                                         attributes: getAttributedParameters(allignment: .center))
        var otherAyahs = ""
        for i in 0..<ayahs.count{
            let ayah = ayahs[i]
            var ayahText = ayah.text!
            if i == 0 {
                ayahText = String(ayahText.dropFirst(23))
            }
            
            let ayahNumber = getArabicDigitFor(value: ayah.numberInSurah!)
            otherAyahs +=  ayahText + " \u{FD3F}" + "\(ayahNumber)" + "\u{FD3E} "
        }

        attributedString.append(NSMutableAttributedString(string:otherAyahs,attributes: getAttributedParameters(allignment: .justified)))
        
        return attributedString
    }
    
    
    private func getAttributedParameters(allignment: NSTextAlignment) -> [NSAttributedString.Key: Any]{
        let font = UIFont(name: "me_quran", size: 24)
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = allignment
        paragraph.baseWritingDirection = .rightToLeft
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font as Any,
            .paragraphStyle: paragraph
        ]
        return attributes
    }
    
    private func configureBesmEllahAyah(firstAyah ayah: Ayah) -> String{
        let besmellahAyahCharsCount = 22
        var text = ""
        if let ayahText = ayah.text{
            let ayahNumber = getArabicDigitFor(value: ayah.numberInSurah!)
            if surah?.number == 1{
                text = ayahText + " \u{FD3F}" + "\(ayahNumber)" + "\u{FD3E} \n"
            }else{
                let besmellah = ayahText.prefix(besmellahAyahCharsCount)
                let remainingAyah = ayahText.dropFirst(besmellahAyahCharsCount + 1) // +1 for the space
                text = besmellah + "\n" + remainingAyah + " \u{FD3F}" + "\(ayahNumber)" + "\u{FD3E} "
            }
        }
        return text
    }
    
    func getArabicDigitFor(value:Int) -> String{
        let numberToConvert = NSNumber(value: value)
        let formatter = NumberFormatter()
        let arLocale = Locale(identifier: "ar")
        formatter.locale = arLocale
        return formatter.string(from: numberToConvert)!
    }
    
}
