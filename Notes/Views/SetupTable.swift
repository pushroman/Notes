//
//  SetupTable.swift
//  Notes
//
//  Created by Роман Пушкарев on 23.11.2024.
//

import UIKit

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Реаизация количества ячеек
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltring {
            return filtredNotes.count // отфильтрованное количество количество по поиску
        }
        return note.notes.count // хранимое количество
    }
    
    // MARK: Реаизация текста в ячейке
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "mainCell")
        var NoteItem: Note
        
        if isFiltring {
            NoteItem = filtredNotes[indexPath.row]
        } else {
            NoteItem = note.notes[indexPath.row]
        }
        
        cell.textLabel?.text = NoteItem.title // передается либо отфильтрованный либо хранимые заметки
        cell.textLabel?.font = UIFont(name: "Gilroy-Semibold", size: 17)
        cell.detailTextLabel?.text = DateFormatter.localizedString(from: Date(timeIntervalSince1970: NoteItem.date), dateStyle: .short, timeStyle: .short)
        cell.detailTextLabel?.font = UIFont(name: "Gilroy-Medium", size: 14)
        cell.detailTextLabel?.textColor = Color.shared.lightText // кастомный цвет
        return cell
    }
    
    // MARK: Реаизация удаления ячейки
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { action, view, completionHandler in
            DataLogic.shared.notes.remove(at: indexPath.row) // удаляем ячейку из массива памяти UserDefaults
            DataLogic.shared.saveNote() // сохраняем именения в массиве памяти UserDefaults
            tableView.deleteRows(at: [indexPath], with: .fade) // стиль удаления
            completionHandler(true) // действие выполнено
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

        
        // MARK: Ширина ячейки
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { // задаем ширину ячейки
            return 60.0
        }
    
    // MARK: Реализация прехода в NoteViewController через  ячейку
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteVC = NoteViewController()
        var selectItem: Note
        
        if isFiltring {
            selectItem = filtredNotes[indexPath.row]
        } else {
            selectItem = note.notes[indexPath.row]
        }
    
        noteVC.item = selectItem
        noteVC.flag = false
        navigationController?.pushViewController(noteVC, animated: true)
    }
}
