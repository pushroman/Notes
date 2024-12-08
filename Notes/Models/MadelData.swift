//
//  MadelData.swift
//  Notes
//
//  Created by Роман Пушкарев on 22.11.2024.
//

import Foundation
struct Note: Codable {
    let idNote: UUID
    var title: String
    let text: String
    var date: TimeInterval
}
