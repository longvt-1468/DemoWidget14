//
//  Status+.swift
//  Shared
//
//  Created by vu.thanh.long on 7/15/20.
//

import SwiftUI

extension Status {
    var iconName: String {
        switch self {
        case .goodService, .noIssues:
            return "checkmark.circle.fill"
        case .information:
            return "info.circle.fill"
        default: return "exclamationmark.triangle.fill"
        }
    }

    var color: Color {
        switch self {
        case .goodService, .noIssues:
            return .green
        case .information:
            return .blue
        case .partSuspended, .minorDelays, .noStepFreeAccess, .specialService:
            return .orange
        default: return .red
        }
    }
}
