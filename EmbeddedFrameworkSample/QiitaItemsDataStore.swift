//
//  QiitaItemsDataStore.swift
//  EmbeddedFrameworkSample
//
//  Created by iniad on 2019/04/09.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import Domain
import UIKit

class QiitaItemsDataStore: NSObject {
    private var items: [Item] = []
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(QiitaItemsTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
}

extension QiitaItemsDataStore: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QiitaItemsTableViewCell
        return cell
    }
}
