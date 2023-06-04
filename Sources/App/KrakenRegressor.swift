//
// KrakenRegressor.swift
//
// This file was automatically generated and should not be edited.
//

import CoreML
import Vapor


/// Model Prediction Input Type
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class KrakenRegressorInput : MLFeatureProvider {

    /// Day as double value
    var Day: Double

    /// Start as double value
    var Start: Double

    /// End as double value
    var End: Double

    var featureNames: Set<String> {
        get {
            return ["Day", "Start", "End"]
        }
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "Day") {
            return MLFeatureValue(double: Day)
        }
        if (featureName == "Start") {
            return MLFeatureValue(double: Start)
        }
        if (featureName == "End") {
            return MLFeatureValue(double: End)
        }
        return nil
    }
    
    init(Day: Double, Start: Double, End: Double) {
        self.Day = Day
        self.Start = Start
        self.End = End
    }

}


/// Model Prediction Output Type
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class KrakenRegressorOutput : MLFeatureProvider {

    /// Source provided by CoreML
    private let provider : MLFeatureProvider

    /// Value as double value
    var Value: Double {
        return self.provider.featureValue(for: "Value")!.doubleValue
    }

    var featureNames: Set<String> {
        return self.provider.featureNames
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        return self.provider.featureValue(for: featureName)
    }

    init(Value: Double) {
        self.provider = try! MLDictionaryFeatureProvider(dictionary: ["Value" : MLFeatureValue(double: Value)])
    }

    init(features: MLFeatureProvider) {
        self.provider = features
    }
}


/// Class for model loading and prediction
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class KrakenRegressor {
    let model: MLModel

    /// URL of model assuming it was installed in the same bundle as this class
    class var urlOfModelInThisBundle : URL {
        let directory = DirectoryConfiguration.detect()
        return URL(fileURLWithPath: directory.workingDirectory)
            .appendingPathComponent("Resource/Regressor/KrakenRegressor.mlmodelc",
                                    isDirectory: true
            )
    }

    /**
        Construct KrakenRegressor instance with an existing MLModel object.

        Usually the application does not use this initializer unless it makes a subclass of KrakenRegressor.
        Such application may want to use `MLModel(contentsOfURL:configuration:)` and `KrakenRegressor.urlOfModelInThisBundle` to create a MLModel object to pass-in.

        - parameters:
          - model: MLModel object
    */
    init(model: MLModel) {
        self.model = model
    }

    /**
        Construct KrakenRegressor instance by automatically loading the model from the app's bundle.
    */
    @available(*, deprecated, message: "Use init(configuration:) instead and handle errors appropriately.")
    convenience init() {
        try! self.init(contentsOf: type(of:self).urlOfModelInThisBundle)
    }

    /**
        Construct a model with configuration

        - parameters:
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    convenience init(configuration: MLModelConfiguration) throws {
        try self.init(contentsOf: type(of:self).urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct KrakenRegressor instance with explicit path to mlmodelc file
        - parameters:
           - modelURL: the file url of the model

        - throws: an NSError object that describes the problem
    */
    convenience init(contentsOf modelURL: URL) throws {
        try self.init(model: MLModel(contentsOf: modelURL))
    }

    /**
        Construct a model with URL of the .mlmodelc directory and configuration

        - parameters:
           - modelURL: the file url of the model
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    convenience init(contentsOf modelURL: URL, configuration: MLModelConfiguration) throws {
        try self.init(model: MLModel(contentsOf: modelURL, configuration: configuration))
    }

    /**
        Construct KrakenRegressor instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    class func load(configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<KrakenRegressor, Error>) -> Void) {
        return self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration, completionHandler: handler)
    }

    /**
        Construct KrakenRegressor instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
    */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    class func load(configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> KrakenRegressor {
        return try await self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct KrakenRegressor instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<KrakenRegressor, Error>) -> Void) {
        MLModel.load(contentsOf: modelURL, configuration: configuration) { result in
            switch result {
            case .failure(let error):
                handler(.failure(error))
            case .success(let model):
                handler(.success(KrakenRegressor(model: model)))
            }
        }
    }

    /**
        Construct KrakenRegressor instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
    */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> KrakenRegressor {
        let model = try await MLModel.load(contentsOf: modelURL, configuration: configuration)
        return KrakenRegressor(model: model)
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as KrakenRegressorInput

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as KrakenRegressorOutput
    */
    func prediction(input: KrakenRegressorInput) throws -> KrakenRegressorOutput {
        return try self.prediction(input: input, options: MLPredictionOptions())
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as KrakenRegressorInput
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as KrakenRegressorOutput
    */
    func prediction(input: KrakenRegressorInput, options: MLPredictionOptions) throws -> KrakenRegressorOutput {
        let outFeatures = try model.prediction(from: input, options:options)
        return KrakenRegressorOutput(features: outFeatures)
    }

    /**
        Make a prediction using the convenience interface

        - parameters:
            - Day as double value
            - Start as double value
            - End as double value

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as KrakenRegressorOutput
    */
    func prediction(Day: Double, Start: Double, End: Double) throws -> KrakenRegressorOutput {
        let input_ = KrakenRegressorInput(Day: Day, Start: Start, End: End)
        return try self.prediction(input: input_)
    }

    /**
        Make a batch prediction using the structured interface

        - parameters:
           - inputs: the inputs to the prediction as [KrakenRegressorInput]
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as [KrakenRegressorOutput]
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    func predictions(inputs: [KrakenRegressorInput], options: MLPredictionOptions = MLPredictionOptions()) throws -> [KrakenRegressorOutput] {
        let batchIn = MLArrayBatchProvider(array: inputs)
        let batchOut = try model.predictions(from: batchIn, options: options)
        var results : [KrakenRegressorOutput] = []
        results.reserveCapacity(inputs.count)
        for i in 0..<batchOut.count {
            let outProvider = batchOut.features(at: i)
            let result =  KrakenRegressorOutput(features: outProvider)
            results.append(result)
        }
        return results
    }
}
