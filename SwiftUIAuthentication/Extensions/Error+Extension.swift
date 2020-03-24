//
//  Error+Extension.swift
//  SwiftUIAuthentication
//
//  Created by Alfian Losari on 24/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import Foundation

extension NSError: Identifiable {
    public var id: Int { code }
}

