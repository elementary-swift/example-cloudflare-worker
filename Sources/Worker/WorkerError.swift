enum WorkerError: String, Error, CustomStringConvertible {
    case notFound = "Not found"
    case invalidRequestJSON = "Invalid request JSON"
    case invalidMessageCount = "count must be between 0 and 10000"

    var description: String { rawValue }
}
