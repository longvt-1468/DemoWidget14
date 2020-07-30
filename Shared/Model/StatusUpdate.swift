//
//  StatusUpdate.swift
//  Shared
//
//  Created by vu.thanh.long on 7/15/20.
//

import Foundation

struct StatusUpdate: Identifiable, Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case type = "statusSeverityDescription"
        case reason = "reason"
    }

    let id: Int
    let type: Status
    let reason: String?
}

