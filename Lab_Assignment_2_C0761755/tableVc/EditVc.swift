//
//  EditVc.swift
//  Lab_Assignment_2_C0761755
//
//  Created by Anmol Sharma on 2020-01-22.
//  Copyright © 2020 anmol. All rights reserved.
//

import UIKit
import CoreData
class EditVc: UIViewController {
    
    var temp = Tasks()
    var tArray : [Tasks] = []
    @IBOutlet var etitle: UITextField!
    @IBOutlet var edaysR: UITextField!
    @IBOutlet var edaysC: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        etitle.text = temp.todo
        edaysR.text = String(temp.daysRequired)
        edaysC.text = String(temp.daysCompleted)
        loadFromCoreData()
        
        
        
        
    }
    func dataUpdation()
    {
        //Setting up the app delegate
               guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
               //creating context from the container
               let context = appDelegate.persistentContainer.viewContext
        let title = etitle.text
        let daysR = Int(edaysR.text!)
        let daysC = Int(edaysC.text!)
        print("data in temp")
        
               print(temp)
               temp.setValue(title, forKey: "todo")
               temp.setValue(daysR, forKey: "daysRequired")
               temp.setValue(daysC, forKey: "daysCompleted")
               do{
                   try context.save()
               }catch let error as NSError
               {
                   print("Error Could not save Data. \(error),\(error.userInfo)")
                   }
               
    }
    
    @IBAction func updateTask(_ sender: Any) {
       
        dataUpdation()
        navigationController?.popViewController(animated: true)
    }
    
    func loadFromCoreData()
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            tArray = try context.fetch(Tasks.fetchRequest())
            print(tArray)
        }
        catch let error as NSError
        {
            print("Error Could not save Data. \(error),\(error.userInfo)")
        }
    }
    func deleteTask()
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
        let predicate = NSPredicate(format: "todo = %@", "\(temp.todo!)")
//        tArray = try context.fetch(Tasks.fetchRequest())
       fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = predicate
        if let result = try? context.fetch(fetchRequest)
        {
            for i in result
            {
               print(i)
                context.delete(i as! NSManagedObject)
                print("Task Deleted")
                print(i)
            }
        }
        do{
            try context.save()
        }
        catch let error as NSError
        {
            print("Error Could not save Data. \(error),\(error.userInfo)")
        }
    }
    
}
