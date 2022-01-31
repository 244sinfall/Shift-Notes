//
//  MainTableViewController.swift
//  Shift Notes
//
//  Created by Дмитрий Филин on 31.01.2022.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController {
    var notesList: [Note] = []
//    {
//        didSet {
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBAction func addButtonAction(_ sender: UIBarButtonItem) {
        let newNote = Note(context: context)
        newNote.dateCreated = Date(timeIntervalSinceNow: 0)
        newNote.title = "Новая заметка"
        notesList.insert(newNote, at: 0)
        do {
            try context.save()
        }
        catch {
            // Доделать
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func loadData() {
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            notesList = try context.fetch(request) as! [Note]
            tableView.reloadData()
        }
        catch {
            // Доделать
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notesList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noteCell = tableView.dequeueReusableCell(withIdentifier: "NotesTitles", for: indexPath) as! NotesTitlesCell
        noteCell.noteDateCreatedLabel.text = notesList[indexPath.row].dateCreated!.formatted(date: .numeric, time: .omitted)
        noteCell.noteTitleLabel.text = notesList[indexPath.row].title
        // Configure the cell...

        return noteCell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(notesList[indexPath.row])
            notesList.remove(at: indexPath.row)
            do {
                try context.save()
            }
            catch {
                // Доделать
            }
            DispatchQueue.main.async {
                tableView.deleteRows(at: [indexPath], with: .left)
                tableView.reloadData()
            }
        }
        /*else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    */
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

}
