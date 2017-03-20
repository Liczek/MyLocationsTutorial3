//
//  File.swift
//  MyLocationTutorial3
//
//  Created by Paweł Liczmański on 20.03.2017.
//  Copyright © 2017 Paweł Liczmański. All rights reserved.
//

import Foundation

extension String {
    mutating func add(text: String?, separatedBy separator: String = "") {
        if let text = text {
            if !isEmpty {
                self += separator
            }
            self += text
        }
    }
}
