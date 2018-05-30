//
//  AppDelegate.swift
//  MyLocations
//
//  Created by Nguyen Van An on 22/05/2018.
//  Copyright © 2018 An. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //MARK: - Add Core Data Stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: {
            storeDescription, error in
            if let error = error {
                fatalError("Could load data store: \(error)")
            }
        })
        return container
    }()
    
    //Get NSManagedObjectContext
    lazy var managedObjectContext: NSManagedObjectContext = self.persistentContainer.viewContext


    //Provide reference of managedObjectContext to CurrentLocationViewController
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        print(applicationDocumentsDirectory)
        
        let tabController = window?.rootViewController as! UITabBarController
        
        if let tabViewController = tabController.viewControllers {
            let navController = tabViewController[0] as! UINavigationController
            let controller = navController.viewControllers.first as! CurrentLocationViewController
            controller.managedObjectContext = managedObjectContext
        }
        listenForFatalCoreDataNotifications()
        return true
    }
    
    //MARK: -Listen for core data error method
    func listenForFatalCoreDataNotifications() {
        NotificationCenter.default.addObserver(forName: CoreDataSaveFailedNotification, object: nil, queue: OperationQueue.main, using: { notification in
            let message = """
There was a fatal error in the app and it cannot continue.

Press OK to terminate the app. Sorry for the inconvenience.
"""
            let alert = UIAlertController(title: "Internal error", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { _ in
                let exception = NSException(name: NSExceptionName.internalInconsistencyException, reason: "Fatal Core Data error", userInfo: nil)
                exception.raise()
            }
            alert.addAction(action)
            
            let tabController = self.window!.rootViewController!
            tabController.present(alert, animated: true, completion: nil)
        })
    }




}

