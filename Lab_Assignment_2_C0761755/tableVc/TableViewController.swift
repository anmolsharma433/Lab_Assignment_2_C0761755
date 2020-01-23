//
//  TableViewController.swift
//  Lab_Assignment_2_C0761755
//
//  Created by Anmol Sharma on 2020-01-22.
//  Copyright © 2020 anmol. All rights reserved.
//

import UIKit
import CoreData
class TableViewController: UITableViewController,UISearchBarDelegate {
    
    //array of task Entity
    var task : [Tasks] = []
    var tempSearch : [Tasks] = []
    var isSearch = false
    let tableCell = TableViewCell()
    //search bar
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
       
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchedData = task.filter{ ($0.todo!.lowercased().contains(searchText.lowercased()))}
        
         if searchedData.count>0
               {
                //tasks = []
                   tempSearch = searchedData;
                  isSearch = true;
               }
               else
               {
                tempSearch = self.task
                   isSearch = false;
                //sself.tableView.reloadData();
               }
               self.tableView.reloadData();
        
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool
       {
           return true;
       }
    
    override func viewWillAppear(_ animated: Bool) {
        //getting data from core data
        retrieveTask()
        //reloading the data
        tableView.reloadData()
        //deleteData()
    }
    
    //Sort By name Function
    @IBAction func sortByName(_ sender: Any) {
        task.sort(by:  {$0.todo!.lowercased() < $1.todo!.lowercased()} )
        
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return task.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let taskDetail = task[indexPath.row]
        cell.title.text = taskDetail.todo
        cell.totalDays.text = "Total Days : \(String(taskDetail.daysRequired))"
        cell.daysCompleted.text = "Days Worked : \(String(taskDetail.daysCompleted))"
        
        let daysLeft = (taskDetail.daysRequired - taskDetail.daysCompleted)
        if (daysLeft <= 0)
        {
            cell.daysLeft.textColor = UIColor.red
            let fontsize : CGFloat = 16
            cell.daysLeft.font = UIFont.boldSystemFont(ofSize: fontsize)
            cell.daysLeft.text = "Completed"
        }
        else{
            cell.daysLeft.text = "Days Left : \(String(taskDetail.daysRequired - taskDetail.daysCompleted))"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentVc = UIStoryboard(name: "Main", bundle: nil)
        let destinationVc = currentVc.instantiateViewController(withIdentifier: "EditVc") as! EditVc
        destinationVc.temp = task[indexPath.row]
        
        navigationController?.pushViewController(destinationVc, animated: true)
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if editingStyle == .delete {
            let tempTask = task[indexPath.row]
            context.delete(tempTask)
            print("Deleted the task")
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do
            {
                task = try context.fetch(Tasks.fetchRequest())
            }
            catch let error as NSError{
                print("Error in deleting the data. \(error),\(error.userInfo)")
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    //uiAlertAction
    func daysCompletedAction()
    {
        let alert = UIAlertController(title: "Error", message: "No. of days Completed can't be greater then no of days required", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        tableCell.daysCompleted.text = tableCell.daysCompleted.text
        
        self.present(alert, animated: true)
    }
    
    
    //retrieve Contact
    func retrieveTask()
    {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        
        let Context = appDelegate.persistentContainer.viewContext
        
        
        
        do{
            task = try Context.fetch(Tasks.fetchRequest() )
            print("Data Successfully retrieved")
        }
        catch let error as NSError{
            print("Error Could not save Data. \(error),\(error.userInfo)")
        }
        
    }
    
    func deleteData()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
        fetchRequest.returnsObjectsAsFaults = false
        do{
            let results = try context.fetch(fetchRequest)
            
            for managedObjects in results{
                if let managedObjectsData = managedObjects as? NSManagedObject
                {
                    context.delete(managedObjectsData)
                }
                
            }
        }
        catch let error as NSError{
            print("Error Could not save Data. \(error),\(error.userInfo)")
        }
    }
    
    
}
