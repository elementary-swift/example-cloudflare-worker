import JavaScriptKit
import NewCodable

@JSClass(jsName: "Response", from: .global)
struct FetchResponse {
    @JSGetter var ok: Bool
    @JSGetter var status: Int
    @JSFunction func bytes() async throws(JSException) -> [UInt8]
}

@JSFunction(jsName: "fetch", from: .global)
private func jsFetch(_ input: String, _ options: JSObject) async throws(JSException)
    -> FetchResponse

extension FetchResponse {
    func decode<T: JSONDecodable>(as type: T.Type) async throws -> T {
        let bytes = try await bytes()
        return try NewJSONDecoder().decode(type, from: bytes.span.bytes)
    }
}

enum FetchError: Error, CustomStringConvertible {
    case httpStatus(Int)

    var description: String {
        switch self {
        case .httpStatus(let status): "The server returned HTTP \(status)"
        }
    }
}

func fetch<Response: JSONDecodable>(
    _ path: String,
    as type: Response.Type
) async throws -> Response {
    try await fetch(path, options: ["method": .string("GET")], as: type)
}

func fetch<Response: JSONDecodable>(
    _ path: String,
    json body: some JSONEncodable,
    as type: Response.Type
) async throws -> Response {
    try await fetch(
        path,
        options: [
            "method": .string("POST"),
            "headers": .object(["content-type": .string("application/json")]),
            "body": .string(try NewJSONEncoder().encodeToString(body)),
        ],
        as: type)
}

private func fetch<Response: JSONDecodable>(
    _ path: String,
    options: JSObject,
    as type: Response.Type
) async throws -> Response {
    let response = try await jsFetch(path, options)
    guard try response.ok else {
        throw FetchError.httpStatus(try response.status)
    }
    return try await response.decode(as: type)
}
