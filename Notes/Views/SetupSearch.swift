//
//  SetupSearch.swift
//  Notes
//
//  Created by Роман Пушкарев on 07.12.2024.
//

import UIKit

// MARK: Реализация поиска ячеек
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    private func filterContentForSearchText(_ searchText: String) { // зполняем массив filtredNotes отфильтрованными даннымми
        filtredNotes = note.notes.filter({ (note: Note) in
            return note.title.lowercased().contains(searchText.lowercased()) // возвращаем последовательность символов в который пользователь набрал не зависимости от регистров этих сиволов
        })
        
        tableView.reloadData()
    }
    
    private var searchBarIsEmpty: Bool {
        guard let text = search.searchBar.text else { return false }
        return text.isEmpty // должна возврвщать true если строка пустая
    }
    // если строка активирована и не является пустой
    var isFiltring: Bool {
        return search.isActive && !searchBarIsEmpty
    }
    
}


