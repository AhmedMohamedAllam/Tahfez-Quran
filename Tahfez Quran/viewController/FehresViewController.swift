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
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
    //    }
    
}

