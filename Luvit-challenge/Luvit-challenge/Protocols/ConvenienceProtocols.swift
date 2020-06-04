//
//  ConvenienceProtocols.swift
//  Luvit-challenge
//
//  Created by Fernando Martin Garcia Del Angel on 02/06/20.
//  Copyright © 2020 Fernando Martin Garcia Del Angel. All rights reserved.
//

import Foundation

protocol LoggableClass {
    func logger(message: String)
}

protocol PostConfigurator {
    func configure(with post: Child)
}
