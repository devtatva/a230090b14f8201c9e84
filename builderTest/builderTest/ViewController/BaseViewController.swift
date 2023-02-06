//
//  BaseViewController.swift
//  builderTest
//
//  Created by pcq186 on 06/02/23.
//

import UIKit

class BaseViewController: UIViewController {

    func showNavTitle(title: String) {
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        let barItem = UIBarButtonItem(customView: label)
        navigationItem.rightBarButtonItems = [barItem]
    }
}
