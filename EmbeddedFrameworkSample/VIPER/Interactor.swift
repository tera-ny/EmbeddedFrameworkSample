//
//  Interactor.swift
//  EmbeddedFrameworkSample
//
//  Created by haruta yamada on 2019/03/30.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit

class Interactor {
    weak var presenter: InteractorDelegate?
}
protocol InteractorDelegate: class {}
