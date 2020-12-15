//
//  ViewControllerExtension.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/15.
//

import UIKit

extension UIViewController {
    func clearNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.shadowColor = .clear
        navBarAppearance.shadowImage = UIImage()
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.navigationController?.navigationBar.barTintColor = .systemBackground
    }
}
