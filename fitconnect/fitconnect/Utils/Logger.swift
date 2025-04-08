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
    if message.isEmpty {
        print("")  // Print an empty line if message is empty
    } else {
        print("[DEBUG] \(message)")  // Print the message if it's not empty
    }
#endif

    }
}

