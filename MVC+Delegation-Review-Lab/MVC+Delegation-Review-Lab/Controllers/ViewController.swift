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
    
    // Reload cells in tableView with font size determined in settingsVC before viewController appears
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Sets tableView dataSource protocol to pull from dataSource func in viewController (self)
        tableView.dataSource = self
         // Sets delegate protocol to the tableView and apply any delegates to viewController (self)
        tableView.delegate = self
    }
    
    // MARK: - Navigation Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Guard for misidentified segues
        guard segue.identifier == "clickToSettingsSegue"
            else { fatalError("Misidentified segue") }
        // Guard for misidentified View Controllers
        guard let settingsVC = segue.destination as? SettingsViewController
            else { fatalError("Mysterious VC!") }
        
        // Sets any instance of delegate fontChange from the settingsVC and applies the properties of the delegate to this ViewController to create an unique instance of this ViewController
        settingsVC.fontChange = self
        // Sets the startingFontSize in the settingsVC to be what the current size in this view controller so that the stepper and slider do not reset from the current font values
        settingsVC.startingFontSize = currentFontSize
    }

}

// MARK: - TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Sets number of rows in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    // Sets title and subtitle label for each cell given model data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movie = movies[indexPath.row]
        // Applies prototype cell "movieCell" style
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
    // Sets currentFontSize of cells in ViewController to newFrontSize which is determined in settingsVC
    func changeCurrentFontSize(to newFontSize: Int) {
        currentFontSize = newFontSize
    }
}
