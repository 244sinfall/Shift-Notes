//
//  NoteEditViewController.swift
//  Shift Notes
//
//  Created by Дмитрий Филин on 01.02.2022.
//

import UIKit

class NoteEditViewController: UIViewController, UITextViewDelegate {

    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var editingObject: Note!
    
    @IBOutlet weak var noteTitleEditor: UITextField!
    @IBOutlet weak var fullTextEditor: NoteEditTextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fullTextEditor.delegate = self
        noteTitleEditor.text = editingObject.title ?? "Новая заметка"
        fullTextEditor.text = editingObject.fulltext as? String

        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
//        var hasChanges = false
        if editingObject.title != noteTitleEditor.text {
            editingObject.title = noteTitleEditor.text
//            hasChanges = true
        }
        if editingObject.fulltext != editingObject.fulltext {
            editingObject.fulltext = fullTextEditor.text as NSObject?
//            hasChanges = true
        }
//        if hasChanges == true {
//            do {
//                try context.save()
//            }
//            catch let raisedError {
//                print(raisedError)
//            }
//        }
    }
    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }
    func textViewDidChangeSelection(_ textView: UITextView) {
        print(fullTextEditor.text)
    }
    func textViewDidChange(_ textView: UITextView) {

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
