//
//  Router.swift
//  EmbeddedFrameworkSample
//
//  Created by haruta yamada on 2019/03/30.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit

class Router {
    weak var viewController: UIViewController?
    private init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    static func createModules() -> UIViewController {
        let view: BaseViewController = BaseViewController()
        let interactor: Interactor = Interactor()
        let router: Router = Router(viewController: view)
        let presenter: Presenter = Presenter(view: view, interactor: interactor, router: router)
        interactor.presenter = presenter
        view.presenter = presenter
        
        return view
        
    }
}
