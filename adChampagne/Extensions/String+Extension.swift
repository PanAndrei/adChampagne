//
//  String+Extension.swift
//  adChampagne
//
//  Created by Andrei Panasenko on 05.01.2023.
//

import SwiftUI

extension String {
    var localized: LocalizedStringKey {
        return LocalizedStringKey(self)
    }
}

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
