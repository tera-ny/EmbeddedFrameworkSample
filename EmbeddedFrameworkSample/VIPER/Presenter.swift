//
//  Presenter.swift
//  EmbeddedFrameworkSample
//
//  Created by haruta yamada on 2019/03/30.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit

class Presenter<V: View, I: Interactor, R: Router>: InteractorDelegate {
    weak var view: V?
    var interactor: I
    var router: R
    
    init(view: V, interactor: I, router: R) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
