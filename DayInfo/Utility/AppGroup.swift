//
//  AppGroup.swift
//  DayInfo
//
//  Created by 유연탁 on 2023/01/09.
//

import Foundation

public enum AppGroup: String {
  case facts = "group.com.ryuyeon.SimpleTodo"

  public var containerURL: URL {
    switch self {
    case .facts:
      return FileManager.default.containerURL(
      forSecurityApplicationGroupIdentifier: self.rawValue)!
    }
  }
}
