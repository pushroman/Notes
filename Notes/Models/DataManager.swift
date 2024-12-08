//
//  DataManager.swift
//  Notes
//
//  Created by Роман Пушкарев on 26.11.2024.
//

//import UIKit
//
//class DataManager {
//    var container: [Note] = []
//    let dataLogic = DataLogic()
//    
//    init() {
//        container = dataLogic.load()
//    }
//    
//    func addNote (idNote: UUID, title: String, text: String, date: Int) -> Note {
//        let newNote = Note(idNote: idNote, title: title, text: text, date: date)
//        container.append(newNote)
//        dataLogic.save(container)
//        return newNote
//    }
//    
//    func load() -> [Note] {
//        return dataLogic.load()
//    }
//    
//    func loadId() -> [UUID] {
//        let notes = load()
//        return notes.map {$0.idNote}
//    }
//    
//    func loadTitle() -> [String] {
//        let notes = load()
//        return notes.map {$0.title}
//    }
//    
//    func loadText() -> [String] {
//        let notes = load()
//        return notes.map {$0.text}
//    }
//    
//    func loadDate() -> [Int] {
//        let notes = load()
//        return notes.map {$0.date}
//    }
//    
//}





