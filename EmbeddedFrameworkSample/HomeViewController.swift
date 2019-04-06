//
//  HomeViewController.swift
//  EmbeddedFrameworkSample
//
//  Created by iniad on 2019/04/05.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    let backGroundView: UIView = {
        let view = UIView()
        view.frame = UIScreen.main.bounds
        view.backgroundColor = UIColor.blue
        return view
    }()
    
    override func loadView() {
        super.loadView()
        self.view = backGroundView
    }
    
}
