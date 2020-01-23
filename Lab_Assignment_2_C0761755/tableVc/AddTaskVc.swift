//
//  AddTaskVc.swift
//  Lab_Assignment_2_C0761755
//
//  Created by Anmol Sharma on 2020-01-22.
//  Copyright © 2020 anmol. All rights reserved.
//

import UIKit
import CoreData
class AddTaskVc: UIViewController {
    let coreData = CoreData()
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var daysRequired: UITextField!
    @IBOutlet weak var daysCompleted: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveTask(_ sender: Any) {
        let daysR = Int(daysRequired.text!) ?? 0
        let daysC = Int(daysCompleted.text!) ?? 0
        if daysC > daysR
        {
            daysCompletedAction()
            
           
        }else{
        coreData.saveTask(todo: taskTitle.text!, totalDays: Int(daysRequired.text!)!, daysCompleted: Int(daysCompleted.text!)!)
         navigationController?.popViewController(animated: true)
        }
    }
    
    func daysCompletedAction()
    {
        let alert = UIAlertController(title: "Error No. of days Completed can't be greater then no of days required", message: "Please enter it again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            let daysR = Int(self.daysRequired.text!) ?? 0
            let daysC = Int(self.daysCompleted.text!) ?? 0
            if daysC > daysR
            {
                self.daysCompletedAction()
            }
        }))
        let temp = 0
        daysCompleted.text = String(temp)
        
        self.present(alert, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
