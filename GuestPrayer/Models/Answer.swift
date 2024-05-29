//
//  Answer.swift
//  GuestPrayer-IpadOS
//
//  Created by Kevin Fairuz on 17/05/24.
//

import Foundation

struct Answer: Identifiable {
    let id = UUID()
    let text: String
    let isCorrect: Bool
}


