//
//  HistoryCell.swift
//  The Movie Database
//
//  Created by Furqan on 17/05/2017.
//  Copyright © 2017 Careem. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {
    var string: String {
        set {
            adultLabel.text = newValue
        }
        get {
            return adultLabel.text!
        }
    }
    @IBOutlet private weak var adultLabel: UILabel!
}
