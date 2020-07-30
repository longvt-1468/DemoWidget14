//
//  URLRequest+.swift
//  Shared
//
//  Created by vu.thanh.long on 7/15/20.
//

import Foundation

extension URLRequest {
    private static var baseURL: String { "https://api.tfl.gov.uk/" }

    public static var lineStatus: URLRequest {
        .init(endpoint: "line", "mode", "tube", "status")
    }

    public static func statusForLine(_ line: Line) -> URLRequest {
        .init(endpoint: "line", line.id, "status")
    }

    init(endpoint: String...) {
        guard let url = URL(string: Self.baseURL + "/" + endpoint.joined(separator: "/")) else {
            preconditionFailure("Expected a valid URL")
        }
        self.init(url: url)
    }
}
