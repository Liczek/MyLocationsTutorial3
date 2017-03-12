//
//  LocationDetailsViewController.swift
//  MyLocationTutorial3
//
//  Created by Paweł Liczmański on 09.03.2017.
//  Copyright © 2017 Paweł Liczmański. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import CoreData

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
} ()

class LocationDetailsViewController: UITableViewController {
    
//MARK: - PROPERTIES
    
    var coordinate = CLLocationCoordinate2DMake(0, 0)
    var placemark: CLPlacemark?
    
    var categoryName = "No Category"
    
    var managedObjectContext: NSManagedObjectContext!
    
//MARK: - OUTLETS
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
//MARK: - Actions
    
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done() {
        let hudView = HudView.hud(inView: navigationController!.view, animated: true)
        
        hudView.text = "Tagged"
        
//        afterDelay(0.8, closure: {
//            self.dismiss(animated: true, completion: nil)
//        })
        
        afterDelay(0.7) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
//MARK: - UNWIND SEGUE (Orange Exit)
    
    @IBAction func categoryPickerDidPickCategory(_ segue: UIStoryboardSegue) {
        let controller = segue.source as! CategoryPickerTableView
        categoryName = controller.selectedCategoryName
        categoryLabel.text = categoryName
    }
    
//MARK: VIEWS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView.text = ""
        categoryLabel.text = categoryName
        
        latitudeLabel.text = "\(coordinate.latitude)"
        longitudeLabel.text = "\(coordinate.longitude)"
        
        if let placemark = placemark {
            addressLabel.text = CurentLocationViewController.string(from: placemark)
        } else {
            addressLabel.text = "No Address Found"
        }
        
        dateLabel.text = format(date: Date())
        
        // keyboard dissmis after you enter to TextView and tap out of it
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gestureRecognizer.cancelsTouchesInView = false
        tableView.addGestureRecognizer(gestureRecognizer)
        
        descriptionTextView.keyboardDismissMode = .onDrag
    }
    
//MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 && indexPath.row == 0 {
            return 88
        } else if indexPath.section == 2 && indexPath.row == 2 {
            addressLabel.frame.size = CGSize(width: view.bounds.width - 115, height: 10000)
            addressLabel.sizeToFit()
            addressLabel.frame.origin.x = view.bounds.size.width - addressLabel.frame.size.width - 15
            return addressLabel.frame.size.height + 20
        } else {
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 0 || indexPath.section == 1 {
            return indexPath
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            descriptionTextView.becomeFirstResponder()
        }
    }
    
//MARK: - RANDOM METHODS
    
    func format(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    func hideKeyboard(_ gestureRecognizer: UIGestureRecognizer) {
        let point = gestureRecognizer.location(in: tableView)
        let indexPath = tableView.indexPathForRow(at: point)
        
        if indexPath != nil && indexPath!.section == 0 && indexPath!.row == 0 {
            return
        }
        descriptionTextView.resignFirstResponder()
    }
    
//MARK: - SEGUE
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PickCategory" {
            let controller = segue.destination as! CategoryPickerTableView
            controller.selectedCategoryName = categoryName
        }
    }
    

    
    
    
}
