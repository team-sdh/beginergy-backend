import Vapor
import CoreML

func routes(_ app: Application) throws {
    let corsConfiguration = CORSMiddleware.Configuration(
        allowedOrigin: .all,
        allowedMethods: [.GET, .POST, .PUT, .OPTIONS, .DELETE, .PATCH],
        allowedHeaders: [.accept, .authorization, .contentType, .origin, .xRequestedWith, .userAgent, .accessControlAllowOrigin]
    )
    let cors = CORSMiddleware(configuration: corsConfiguration)
    // cors middleware should come before default error middleware using `at: .beginning`
    app.middleware.use(cors, at: .beginning)
    
    app.get { req async in
        "It work!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.get("predict", ":day") { req async -> String in
        guard let day = req.parameters.get("day", as: Double.self) else {
                return "Bad Parameter"
        }
        
        do {
            let config = MLModelConfiguration()
            let model = try KrakenRegressor(configuration: config)
            
            var halfHourPredictions: [[String:Double]] = []

            for index in 0...23 {
                var prediction1: [String:Double] = [:]
                prediction1["x"] = Double(index)
                prediction1["y"] = try model.prediction(Day: day, Start: Double(index), End: Double(index) + 0.5)
                halfHourPredictions.append(prediction1)
                
                var prediction2: [String:Double] = [:]
                let prediction2 = try model.prediction(Day: day, Start: Double(index) + 0.5, End: Double(index + 1))
                let predictionRead2 = [String(Double(index) + 0.5): prediction2.Value]
                halfHourPredictions.append(predictionRead2)
            }
            
            let jsonData = try JSONSerialization.data(withJSONObject: halfHourPredictions)
            let returnString = String(data: jsonData, encoding: .utf8)
            
            return returnString ?? "Parsing Error"
        } catch {
            return "Error"
        }
    }
}
