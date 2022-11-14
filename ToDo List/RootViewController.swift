//
//  MAPD714 F2022
//  Assignment 4
//  ToDo List App
//  Part 1 - Create the app UI
//  Group 9
//  Member: Suen, Chun Fung (Alan) 301277969
//          Sum, Chi Hung (Samuel) 300858503
//          Wong, Po Lam (Lizolet) 301258847
//
//  RootViewController.swift
//  ToDo List
//  Date: 13 Nov, 2022
//

import UIKit

class RootViewController: UITableViewController {

    private var cellPointSize: CGFloat!
    private var toDoList: ToDoList!
    private static let toDoItemCell = "Items"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoList = ToDoList.sharedToDoList

        //Init table view and cells
        tableView.register(ToDoListViewCell.nib(), forCellReuseIdentifier: ToDoListViewCell.identifier)
        tableView.dataSource = self
        //let preferredTableViewFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        //cellPointSize = preferredTableViewFont.pointSize
        //tableView.estimatedRowHeight = cellPointSize
        tableView.rowHeight = 70
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem!.tintColor = Utility.getUIColor("#FF9292")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // *****
    // define number of sections in the table view
    // *****
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // *****
    // define number of total cells (row) in the table view
    // *****
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       return toDoList.count()
    }

    // *****
    // Called by iOS to reuse / create a table cell for display
    // *****
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = toDoList.getAllItems()
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoListViewCell.identifier, for: indexPath) as! ToDoListViewCell
        cell.configure(with: data[indexPath.row], row: indexPath.row)
        cell.delegate = self
        return cell
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
     */
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .automatic)
    
        }
        //else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        //}    
    }
*/

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        tableView.reloadData()
    }
    

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func didPressedAddButton(_ sender: UIBarButtonItem) {
        print("didPressedAddButton.")
        toDoList.addBlankItem()
        tableView.reloadData()
    }


}

extension RootViewController: ToDoListViewCellDelegate {
    func didChangeSwitchValue(with tag: Int, value: Bool) {
        print ("Switch: \(tag), \(value)")

    }
    
    func didClickedEditButton(with tag: Int) {
        print ("Button: \(tag)")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailScreen")
        //self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc,animated:true)
    }
    
}
