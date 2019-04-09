//
//  ViewController.swift
//  EmbeddedFrameworkSample
//
//  Created by haruta yamada on 2019/03/29.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class QiitaItemsViewController: UIViewController {
    let dataStore = QiitaItemsDataStore()
    override func viewDidLoad() {
        self.view.addSubview(dataStore.tableView)
        self.dataStore.tableView.dataSource = dataStore
        self.setupLayout()
    }
    
    private func setupLayout() {
        self.dataStore.tableView.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            maker.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            maker.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            maker.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
        }
    }
}

