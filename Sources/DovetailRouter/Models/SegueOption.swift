//
//  SegueOption.swift
//  Presentation
//
//  Created by Dmytro Ipatii on 23/10/2026.
//

public enum SegueOption {
    case push, sheet, fullScreenCover

    public var addRootNavigationStack: Bool {
        switch self {
        case .push:
            false
        case .sheet, .fullScreenCover:
            true
        }
    }
}
