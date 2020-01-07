//
//  PersonTVC.swift
//  PersonMsg
//
//  Created by Gianni MEGNA on 09/08/2019.
//  Copyright © 2019 Gianni MEGNA. All rights reserved.
//

import UIKit

class Person: Decodable {
    
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let phone: String?
    let website: String?

    init(id:Int, name:String, username:String, email:String, phone :String, website :String) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.phone = phone
        self.website = website
    }
}



class PersonTVC: UITableViewController, UISearchResultsUpdating {

    var personArray = [Person]()
    var filteredTableData = [Person]()
    var resultSearchController = UISearchController()
    
    @IBOutlet var tableau: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:  #selector(getData), for: .valueChanged)
        self.refreshControl = refreshControl
        getData()
        
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            tableau.tableHeaderView = controller.searchBar
            
            return controller
        })()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if  (resultSearchController.isActive) {
            return filteredTableData.count
        } else {
            return personArray.count
        }
    }

    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text! == "" {
            filteredTableData = personArray
        }else{
        
        filteredTableData.removeAll(keepingCapacity: false)
     
            
            let array = personArray.filter({( person : Person) -> Bool in
                return person.name?.lowercased().contains(searchController.searchBar.text!.lowercased()) ?? false
            })
        filteredTableData = array
        
        }
        self.tableau.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        // Configure the cell...

        if (resultSearchController.isActive) {
            cell.textLabel?.text = filteredTableData[indexPath.row].name
            return cell
        }
        else {
            cell.textLabel?.text = personArray[indexPath.row].name
            return cell
        }
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.tableau.reloadData()
        if editingStyle == .delete {
            personArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    

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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            if let destination = segue.destination as? PersonDetailVC{
                if resultSearchController.isActive{
                    destination.person = filteredTableData[(tableau.indexPathForSelectedRow?.row)!]
                }else{
                    destination.person = personArray[(tableau.indexPathForSelectedRow?.row)!]
                }
            }
    }
    
    
    @objc func getData(){
        let jsonUrlString = "https://jsonplaceholder.typicode.com/users"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            do {
                let persons = try JSONDecoder().decode([Person].self, from: data)
                self.personArray = []
                for person in persons {
                    self.personArray.append(person)
                    
                }
                
                DispatchQueue.main.async {
                    
                    self.tableau.reloadData()
                }
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            }.resume()
         refreshControl?.endRefreshing()
    }
    
 
    
    
}
