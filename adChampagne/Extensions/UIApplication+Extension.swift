//
//  UIApplication+Extension.swift
//  adChampagne
//
//  Created by Andrei Panasenko on 05.01.2023.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
