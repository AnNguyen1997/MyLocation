//
//  LocationsViewController.swift
//  MyLocations
//
//  Created by Nguyen Van An on 30/05/2018.
//  Copyright © 2018 An. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class LocationsViewController: UITableViewController {
    
    var locations = [Location]()
    
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest = NSFetchRequest<Location>()
        
        let entity = Location.entity()
        fetchRequest.entity = entity
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            locations = try managedObjectContext.fetch(fetchRequest)
        } catch  {
            fatalCoreDataError(error)
        }
    }

    // MARK: - Table view delegates

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationCell
        
        let location = locations[indexPath.row]
        cell.configure(for: location)
    
        return cell
    }


}
