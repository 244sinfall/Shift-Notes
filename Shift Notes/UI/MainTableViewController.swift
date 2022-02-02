//
//  MainTableViewController.swift
//  Shift Notes
//
//  Created by Дмитрий Филин on 31.01.2022.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController {
    // Переменная для заметок
    var notesList: [Note] = []
    // NSManagedObjectContext для сохранения и загрузки заметок
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // Кнопка добавляет новую заметку
    @IBAction func addButtonAction(_ sender: UIBarButtonItem) {
        let newNote = Note(context: context)
        newNote.dateCreated = Date(timeIntervalSinceNow: 0)
        newNote.title = "Новая заметка"
        notesList.insert(newNote, at: 0)
        do {
            try context.save()
        }
        catch {
            context.rollback()
            tableView.reloadData()
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    // Локализация для editingStyle кнопки
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Удалить"
    }
    // Переход в NoteEditViewController для редактирования заметки
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editViewControl = storyboard?.instantiateViewController(withIdentifier: "noteEditView") as! NoteEditViewController
        editViewControl.editingObject = notesList[indexPath.row]
        show(editViewControl, sender: self)
    }


    // MARK: - Table view data source

    // У нас одна секция, так что просто один
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // Количество создаваемых строк заметок = количество заметок в массиве
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notesList.count
    }
    // Генерация ячейки с использованием dataSource в виде notesList
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noteCell = tableView.dequeueReusableCell(withIdentifier: "NotesTitles", for: indexPath) as! NotesTitlesCell
        noteCell.noteDateCreatedLabel.text = notesList[indexPath.row].dateCreated!.formatted(date: .numeric, time: .omitted)
        noteCell.noteTitleLabel.text = notesList[indexPath.row].title
        return noteCell
    }
    
    // Включает возможность удалять заметки свайпом
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // Описывает логику удаления заметки свайпом
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(notesList[indexPath.row])
            notesList.remove(at: indexPath.row)
            do {
                try context.save()
            }
            catch {
                // Если что то не может сохраниться - отменяем все изменения и возвращаем в исходный вид
                context.rollback()
                tableView.reloadData()
            }
            DispatchQueue.main.async {
                tableView.deleteRows(at: [indexPath], with: .left)
                tableView.reloadData()
            }
        }
    }
    // Загрузка данных в массив с сортировкой по дате
    func loadData() {
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            notesList = try context.fetch(request) as! [Note]
            if notesList.count >= 2 {
                notesList.sort { first_note, second_note in
                    if let first_element_date = first_note.dateCreated {
                        if let second_element_date = second_note.dateCreated {
                            if first_element_date > second_element_date {
                                return true
                            }
                            else {
                                return false
                            }
                        }
                        else { return false }
                    }
                    else { return false }
                }
            }
            tableView.reloadData()
        }
        catch {
            context.rollback()
            tableView.reloadData()
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
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        print("will appear triggered")
    }

}
