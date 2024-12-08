//
//  SetupColor.swift
//  Notes
//
//  Created by Роман Пушкарев on 07.12.2024.
//

import UIKit

// MARK: настройка кастомного цвета
class Color: UIColor {
    static var shared = Color()
    let main = #colorLiteral(red: 0.1032030657, green: 0.6845958829, blue: 0.9319567084, alpha: 1)
    let text = #colorLiteral(red: 0.1038340107, green: 0.1038340107, blue: 0.1038340107, alpha: 1)
    let lightText = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    let white = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
}
