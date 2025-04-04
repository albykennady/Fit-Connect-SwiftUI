//
//  Logger.swift
//  fitconnect
//
//  Created by Vijil Dhas A S on 04/04/25.
//
import Foundation

class Logger {
    static func log(_ message: String) {
        #if DEBUG
        print("[DEBUG] \(message)")
        #endif
    }
}

