//
//  History.swift
//  The Movie Database
//
//  Created by Furqan on 17/05/2017.
//  Copyright © 2017 Careem. All rights reserved.
//

import Foundation

class History {
    static var items: [String] {
        guard let history = UserDefaults.standard.array(forKey: "history") as? [String] else {
            return []
        }
        return history
    }
    
    static func addItem(string query: String) {
        var history = items
        if history.contains(query) {
            return
        }
        if history.count == 10 {
            history.remove(at: 9)
        }
        history.insert(query, at: 0)
        UserDefaults.standard.setValue(history, forKey: "history")
    }
}
