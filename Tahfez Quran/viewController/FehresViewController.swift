//
//  ViewController.swift
//  Tahfez Quran
//
//  Created by Allam on 9/12/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import UIKit

class FehresViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var quranDownloader: QuranDownloader!
    
    private let CELLID = "fehresTableViewCellId"
    private var arabicSurahsNames: [String]?
    private var francoSurahsNames: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arabicSurahsNames = Fehres.getSurahsNames(for: .arabic)
        francoSurahsNames = Fehres.getSurahsNames(for: .romanized)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let names = arabicSurahsNames{
            return names.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELLID, for: indexPath) as! FehresTableViewCell
        if let arabicNames = arabicSurahsNames{
            cell.arabicNameLabel.text = arabicNames[indexPath.row]
        }
        if let francoNames = francoSurahsNames{
            cell.francoNameLabel.text = francoNames[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let surahNumber = indexPath.row + 1 // increase by one as hehres begins with (0)
         quranDownloader.getSurah(surahNumber: surahNumber) { (surah, error) in
            guard error == nil else{
                self.displayError(error: error!)
                return
            }
            
            if let surah = surah{
                DispatchQueue.main.async {
                    self.presentDisplayViewController(with: surah)
                }
            }
        }
    }
    
    // instanciate displayViewController and open it
    private func presentDisplayViewController(with surah: Surah){
        let displaySurahTextViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "displaySurahText") as! DisplayQuranViewController
        displaySurahTextViewController.surah = surah
        displaySurahTextViewController.modalPresentationStyle = .fullScreen
        self.present(displaySurahTextViewController, animated: true, completion: nil)
    }
    
    private func displayError(error: Error){
        print("coudln't load surah due to this error: " + error.localizedDescription)
    }
    
}

