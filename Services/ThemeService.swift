//
//  ThemeService.swift
//  Goals (iOS)
//
//  Created by Alexander Skorulis on 3/10/21.
//

import Foundation
#if os(iOS)
import UIKit
#else
import AppKit
#endif

struct ThemeService {
    
    static func apply() {
        #if os(iOS)
        UITextView.appearance().backgroundColor = .clear
        #else
        #endif
    }
    
}
