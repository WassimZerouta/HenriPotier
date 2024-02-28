//
//  AppStyle.swift
//  HenryPotier
//
//  Created by Wassim on 12/02/2024.
//

import Foundation
import UIKit

class AppStyle {
    
    static let shared = AppStyle()
    
    private init() {}
    
     func applyGlobalStyle() {
        UINavigationBar.appearance().barTintColor = .systemBackground
        UIBarButtonItem.appearance().tintColor = .label
        UITabBar.appearance().backgroundColor = .systemBackground
        UITabBar.appearance().unselectedItemTintColor = .darkGray
        UITabBar.appearance().selectedImageTintColor = .lightGray
    }
}
