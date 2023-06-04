//
//  File.swift
//  
//
//  Created by Hanh Vu on 2023/06/03.
//

import Vapor
import CoreML

struct RegressorController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.on(.GET,
                  "predict",
                  use: classification
        )
    }

    func classification(req: Request) throws -> String {
        let resInfere = RegressorInferer()
        let day = req.parameters.get("day")!
        let returnData = resInfere.inferValue(day: Double(day) ?? 1)
        let jsonData = try JSONSerialization.data(withJSONObject: returnData)
        let returnString = String(data: jsonData, encoding: .utf8)
        return returnString ?? "Error"
    }
}
