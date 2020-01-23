//
//  CoreData.swift
//  Lab_Assignment_2_C0761755
//
//  Created by Anmol Sharma on 2020-01-22.
//  Copyright © 2020 anmol. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreData {
      func saveTask(todo : String,totalDays : Int,daysCompleted : Int)
        {
            //Setting up the app delegate
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            //creating context from the container
            let context = appDelegate.persistentContainer.viewContext
            let task = Tasks(context: context)
            task.todo = todo
            task.daysRequired = Int64(totalDays)
            task.daysCompleted = Int64(daysCompleted)
            do{
                try context.save()
                print("Data Saved")
            }catch let error as NSError{
                print("Error Could not save Data. \(error),\(error.userInfo)")
            }
        }
        
        
        
        
       
        
       
}
