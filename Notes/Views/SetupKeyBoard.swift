//
//  SetupKeyBoard.swift
//  Notes
//
//  Created by Роман Пушкарев on 07.12.2024.
//

import UIKit

extension NoteViewController: UITextViewDelegate {
    
    // MARK: Настройка отображения клавиатуры и текста
    func setupKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardSetup), name: UIResponder.keyboardDidShowNotification, object: nil) // показывается
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardSetup), name: UIResponder.keyboardWillHideNotification, object: nil) // скрывается
    }
    // реализация отображения клавиатуры и текста
    @objc func keyBoardSetup(param: Notification) {
        let userInfo = param.userInfo
        let keyBoard = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue // установка границ клавиатуры и конвертируем в CGRect таким образом получаем координаты и точки клавиатуры
        let keyBoardFrame = self.view.convert(keyBoard, to: view.window)
        
        if param.name == UIResponder.keyboardWillHideNotification{
            textView.contentInset = UIEdgeInsets.zero // если клавиатура прячется то вернуть весь текс на место
        }else{
            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyBoardFrame.height, right: 0) // если клавиатура появляется то учитовать размеры клавиатуры
            textView.scrollIndicatorInsets = textView.contentInset
        }
        textView.scrollRangeToVisible(textView.selectedRange)
    }
    
    // MARK: Настройка отображения курсора иклавиатуры
    // реализация состояния курсора и клавиатуры при переходе в новую заметку и созданную
    override func viewDidAppear(_ animated: Bool) {
        if flag { // Если при переходе addActionButton приходит true создается новая заметка, курсор активируется сразу
            textView.becomeFirstResponder()
        } else { // Если при переходе существующей заметки didSelectRowAt приходит false, курсор не активируется
            textView.isEditable = false
            textView.isSelectable = false
        }
    }
    
    // состояние курсора и клавиатуры
    override func becomeFirstResponder() -> Bool {
        textView.isEditable = true
        textView.isSelectable = true
        return super.becomeFirstResponder()
    }
    
    // когда перешли в NoteViewController, по тапу на экран активируем курсор и клавиатуру
    func tapKeyBoard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // активация курсура и клавиатуры
    @objc func hideKeyboard() {
        if !flag { // true
            textView.isEditable = true
            textView.isSelectable = true
            textView.becomeFirstResponder()
        }
    }
    
    // MARK: Принудительное скрытие клавиатуры
    func addDoneButtonOnKeyboard() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Создаем кнопку "Готово"
        let doneButton = UIBarButtonItem(image: UIImage(systemName: "keyboard.chevron.compact.down"), style: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        // Добавляем кнопку "Готово" на панель
        toolbar.items = [flexibleSpace, doneButton]
        
        // Устанавливаем панель инструментов для TextView
        textView.inputAccessoryView = toolbar
    }
    // Скрываем клавиатуру
    @objc func doneButtonTapped() {
        textView.resignFirstResponder()
    }
}
    

