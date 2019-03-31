//
//  View.swift
//  EmbeddedFrameworkSample
//
//  Created by haruta yamada on 2019/03/30.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit

protocol View: class {
    var presenter: Presenter<BaseViewController.self, Interactor, Router>? {get set}
}
class BaseViewController: UIViewController, View {
    var presenter: Presenter<BaseViewController., Interactor, Router>?
}
