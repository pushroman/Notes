//
//  MainViewController.swift
//  Notes
//
//  Created by Роман Пушкарев on 22.11.2024.
//

import UIKit

class MainViewController: UIViewController {
    var note = DataLogic.shared
    let tableView = UITableView()
    var filtredNotes: [Note] = [] // хранение отфильтрованный заметок
    let search = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white // цвет view
        title = "Заметки" // заголовок страницы
        
        DataLogic.shared.loadNote() // активируем загрузку таблицы при вкл.
        setupTableView() // таблица заметок
        setupAddButton() // копка добавить
        setupSearch() // поиск
    }
    
    // MARK: Настройка поиска по заметкам
    func setupSearch() {
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Поиск"
        navigationItem.searchController = search
        definesPresentationContext = true // отпускаем строку поиска при переходе на другой экран
    }
    
    // MARK: Настройка таблицы
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        // устанавливаем делегаты
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        view.addSubview(tableView)
        
        // Настраиваем Auto Layout
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), // Вершина таблицы
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),              // Низ таблицы
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),            // Левый край
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)           // Правый край
        ])
    }
    
    // MARK: запуск обновления таблицы прикаждом обращении к view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: Настройка кнопки "Добавить заметку"
    private func setupAddButton() {
        let plusButton = UIButton(type: .system)
        
        // 1 КРУГ
        let circle = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .large) // настраиваем размер круга
        let circleImage = UIImage(systemName: "circle.fill", withConfiguration: circle) // устанавливаем изображение круга
        plusButton.setImage(circleImage, for: .normal) // добавляем изображение круга в кнопку, состояние кнопки нормальное, то есть она не нажата
        plusButton.tintColor = Color.shared.main
        
        // 2 ПЛЮС
        let plus = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold, scale: .large) // настраиваем размер плюса
        let plusImage = UIImage(systemName: "plus", withConfiguration: plus) // устанавливаем изображение плюса
        
        // 3 СБОРКА ПЛЮСА + КНОПКИ
        let plusImageView = UIImageView(image: plusImage) // создаем контейнер в него добавляем плюс
        plusImageView.tintColor = Color.shared.white // устанавливаем цвет плюса
        
        plusImageView.translatesAutoresizingMaskIntoConstraints = false // включаем Auto Layout
        plusButton.addSubview(plusImageView) // добавляем плюс в кнопку поверх круга
        
        NSLayoutConstraint.activate([
            plusImageView.centerXAnchor.constraint(equalTo: plusButton.centerXAnchor),
            plusImageView.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor)
        ])
        
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.addTarget(self, action: #selector(addActionButton), for: .touchUpInside)
        view.addSubview(plusButton)
        
        // Размещаем кнопку в правом нижнем углу
        NSLayoutConstraint.activate([
            plusButton.widthAnchor.constraint(equalToConstant: 80), // размер области нажатия
            plusButton.heightAnchor.constraint(equalToConstant: 80), // размер области нажатия
            plusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            plusButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    // реализация перехода в NoteViewController
    @objc func addActionButton() {
        let noteVC = NoteViewController()
        noteVC.flag = true
        navigationController?.pushViewController(noteVC, animated: true)
    }
}
