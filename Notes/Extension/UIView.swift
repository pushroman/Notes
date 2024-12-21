//
//  UIView.swift
//  Notes
//
//  Created by Роман Пушкарев on 21.12.2024.
//

import UIKit

extension UIView {
    // Добавляем значения по умоланию в UIView
    func addSubviews(_ views: [UIView]) {
        for view in views {
            view.contentMode = .scaleAspectFill
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
    }
}
