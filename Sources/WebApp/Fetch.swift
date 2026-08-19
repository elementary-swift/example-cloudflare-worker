import JavaScriptKit
import NewCodable

@JSClass(jsName: "Response", from: .global)
struct FetchResponse {
    @JSGetter var ok: Bool
    @JSGetter var status: Int
    @JSFunction func bytes() async throws(JSException) -> [UInt8]
}

@JSFunction(from: .global)
func fetch(_ input: String) async throws(JSException) -> FetchResponse

extension FetchResponse {
    func decode<T: JSONDecodable>(as type: T.Type) async throws -> T {
        let bytes = try await bytes()
        return try NewJSONDecoder().decode(type, from: bytes.span.bytes)
    }
}
