//
//  NoteViewController.swift
//  Notes
//
//  Created by Роман Пушкарев on 22.11.2024.
//

import UIKit

class NoteViewController: UIViewController {
    let textView = UITextView()
    var item: Note?
    var flag: Bool = false // флаг (сохраниение заметки и управлениее состоянием курсора и клавиатуры)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white // цвет view
        setupTextView() // настройка textView
        setupKeyboard() // настройка клавиатуры
        textView.text = item?.title // принимаем хронимый текст в textView
        setupButton() // конопки Назад и Готово
        addDoneButtonOnKeyboard() // конопка принудительного скрытия клавиатуры
        tapKeyBoard() // активация курсора по тапу
    }

    // MARK: Настройка оттображение textView во view
    private func setupTextView() {
        textView.font = UIFont(name: "Gilroy-Semibold", size: 16)
        textView.textContainerInset.top = 10
        textView.textContainerInset.left = 20
        textView.textContainerInset.right = 20
        textView.tintColor = Color.shared.main
        view.addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        textView.delegate = self
        //textViewDidChange(textView)
    }
//    func textViewDidChange(_ textView: UITextView) {
//    }
    
// MARK: Кнопки Назад и Готово в navigation
    private func navigationButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont(name: "Gilroy-Semibold", size: 14)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 20) // Размер кнопки
        button.layer.cornerRadius = 13// Овальная форма
        button.layer.masksToBounds = true
        button.backgroundColor = Color.shared.main // Фон кнопки
        button.setTitleColor(.white, for: .normal) // Цвет текста
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    // Кастом кнопки
    private func setupButton() {
        let backButton = navigationButton(title: "Назад", action: #selector(backAction))
        let backBarButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButton
        
        let doneButton = navigationButton(title: "Готово", action: #selector(buttonDoneSave))
        let doneBarButton = UIBarButtonItem(customView: doneButton)
        navigationItem.rightBarButtonItem = doneBarButton
    }
    
    // Кнопка сохранить
    @objc func buttonDoneSave() {
        guard let text = textView.text else { return }  // записываем в text текст который отправили из SetupTable.swift
        print(text)
        // если заметка уже создана и ужно схранить изменения
        if var note = item {
            note.title = text                           // обновим текст в данной ячейке
            note.date = Date().timeIntervalSince1970    // обновим дату заметки
            DataLogic.shared.addNotes(note)             // сохраним изменения "note" через метод "addNotes(note)"
        } else {
        //  иначе если заметка новая, сохраняем
            let text = self.textView.text ?? ""
            let note = Note(
                idNote: UUID(),
                title: text,
                text: "",
                date: Date().timeIntervalSince1970)
            DataLogic.shared.addNotes(note)
        }
        navigationController?.popViewController(animated: true) // выход из NoteViewController
    }
    // Действия принажатии кнопки назад
    @objc func backAction() {
        let saveNote = item?.title ?? ""
        guard let text = self.textView.text else { return }
        
        if (flag && !text.isEmpty) { // если flag при переходе true и !text.isEmpty(text является пустым? - true)
            let alertController = UIAlertController(
                title: "Сохранить изменения?",
                message: nil,
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(title: "Да", style: .default) { _ in
                let text = self.textView.text ?? ""
                let note = Note(
                    idNote: UUID(),
                    title: text,
                    text: "",
                    date: Date().timeIntervalSince1970)
                DataLogic.shared.addNotes(note)
                print("Новый текст сохранен")
                self.navigationController?.popViewController(animated: true)
            }
            
            let cancelAction = UIAlertAction(title: "Нет", style: .default) { _ in
                self.navigationController?.popViewController(animated: true)
            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }else if (!flag && text != saveNote) { // если !flag при переходе true и text не совпадает с сохранённым
            let alertController = UIAlertController(
                title: "Сохранить изменения?",
                message: nil,
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "Да", style: .default) { _ in
                guard var note = self.item else { return }
                note.title = text                           // запишим тект в "note.title" который содержиться в "text"
                note.date = Date().timeIntervalSince1970    // обновим дату заметки т.к. произведено редактирование
                DataLogic.shared.addNotes(note)
                print("Изменения сохранены!")
                self.navigationController?.popViewController(animated: true)
            }
            
            let cancelAction = UIAlertAction(title: "Нет", style: .default) { _ in
                self.navigationController?.popViewController(animated: true)
            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true)
            
        }else{ // если мы не внесли некаких изенений
            self.navigationController?.popViewController(animated: true)
            print("Текста нет или совподает!")
        }
    }
}




