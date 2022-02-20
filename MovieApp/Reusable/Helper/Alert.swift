//
//  Alert.swift
//  MovieApp
//
//  Created by krushankant on 2/19/22.
//  Copyright © 2022 Patel. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    static func present(withTitle title: String, description: String? = nil, from: UIViewController) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(dismissAction)
        from.present(alert, animated: true, completion: nil)
    }
}
