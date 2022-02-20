//
//  ViewBindable.swift
//  MovieApp
//
//  Created by krushankant on 2/19/22.
//  Copyright © 2022 Patel. All rights reserved.
//

import Foundation

protocol ViewBindable {
    func getTitle() -> String
    func getSubtitle() -> String
    func getImageURL() -> URL?
    func getSubText() -> String?
}

extension ViewBindable {
    func getTitle() -> String {
        return ""
    }
    
    func getSubtitle() -> String {
        return ""
    }
    
    func getImageURL() -> URL? {
        return nil
    }
    
    func getSubText() -> String? {
        return nil
    }
}
