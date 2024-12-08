//
//  DataLogic.swift
//  Notes
//
//  Created by Роман Пушкарев on 22.11.2024.
//

import Foundation

class DataLogic {
    static let shared = DataLogic()
    var notes: [Note] = []
    private let key = "notes"
    
    func addNotes(_ note: Note) { /// метод сохранения заметок в UserDefaults
        if let index = notes.firstIndex(where: {$0.idNote == note.idNote}){ // если заметка совпадает (true) обявием индекс в "index" теперь мы можем сохранить заметку по конкретному индексу
            notes[index] = note // изменения, которые мы внесли в "note" (в NoteViewController.swift) сохраним в "notes" по конкретному индексу "index"
        }else{ // если нет совпадения
            notes.append(note) // то даабавим в массив "notes" новую заметку
        }
        saveNote() // выходим и сохраняем "notes" в методе saveNote()
    }
    
    func saveNote() { /// Сохранение заметок в UserDefaults
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(notes)
            UserDefaults.standard.set(data, forKey: key)
            print("Заметка сохранилась")
        }
        catch {
            print("Не удалось сохранить: \(error)")
        }
    }
    
    func loadNote() { /// Загрузка заметок из UserDefaults
        let dencoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: key) {
            
            do {
                notes = try dencoder.decode([Note].self, from: data)
                print("Заметки загрузились")
            }
            catch {
                print("Не удалось загрузить: \(error)")
            }
        }
    }
}
