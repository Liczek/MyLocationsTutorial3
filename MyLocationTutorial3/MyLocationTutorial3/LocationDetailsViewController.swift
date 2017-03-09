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
        dismiss(animated: true, completion: nil)
    }
    
//MARK: VIEWS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView.text = ""
        categoryLabel.text = ""
        
        latitudeLabel.text = "\(coordinate.latitude)"
        longitudeLabel.text = "\(coordinate.longitude)"
        
        if let placemark = placemark {
            addressLabel.text = CurentLocationViewController.string(from: placemark)
        } else {
            addressLabel.text = "No Address Found"
        }
        
        dateLabel.text = format(date: Date())
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
    
//MARK: - RANDOM METHODS
    
    func format(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    

    
    
    
}
