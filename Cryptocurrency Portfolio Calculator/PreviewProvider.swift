//
//  PreviewProvider.swift
//  CryptoChameleon
//
//  Created by Sanay Fatullayeva on 08.02.22.
//

import Foundation
import SwiftUI

extension PreviewProvider{
    static var dev: DeveloperPreview{
        return DeveloperPreview.instance
    }
}

class DeveloperPreview{
    static let instance = DeveloperPreview()
    
    private init () { }
    
}
