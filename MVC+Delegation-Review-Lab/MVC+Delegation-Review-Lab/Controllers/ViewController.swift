//
//  ViewController.swift
//  MVC+Delegation-Review-Lab
//
//  Created by Benjamin Stone on 8/19/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Variables and Constants
    @IBOutlet weak var tableView: UITableView!
    
    let movies = Movie.allMovies
    var currentFontSize = Font.startingFontSize
    
    // MARK: - Life Cycle Functions
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - Navigation Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "clickToSettingsSegue"
            else { fatalError("Misidentified segue") }
        guard let settingsVC = segue.destination as? SettingsViewController
            else { fatalError("Mysterious VC!") }
        
        settingsVC.fontChange = self
        settingsVC.startingFontSize = currentFontSize
    }

}

// MARK: - TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movie = movies[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") {
        
            cell.textLabel?.text = movie.name
            cell.textLabel?.font = cell.textLabel?.font.withSize(CGFloat(currentFontSize))
            cell.detailTextLabel?.text = String(movie.year)
            cell.detailTextLabel?.font = cell.detailTextLabel?.font.withSize(CGFloat(currentFontSize))
        return cell
        }
    return UITableViewCell()
    }
    
}

// MARK: - FontChangeable Protocol
extension ViewController: FontChangeable {
    
    func changeCurrentFontSize(to newFontSize: Int) {
        currentFontSize = newFontSize
    }
}
