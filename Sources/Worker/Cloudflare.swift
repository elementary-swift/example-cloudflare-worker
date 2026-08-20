import JavaScriptKit
import NewCodable

@JSClass(from: .global)
struct Request {
    @JSGetter var method: String
    @JSGetter var url: String
    @JSFunction func bytes() async throws(JSException) -> [UInt8]
}

@JSClass(from: .global)
struct URL {
    @JSGetter var pathname: String
    @JSGetter var searchParams: URLSearchParams
    @JSFunction init(_ input: String) throws(JSException)
}

@JSClass(from: .global)
struct URLSearchParams {
    @JSFunction func get(_ name: String) throws(JSException) -> String?
}

@JSClass(from: .global)
struct Response {
    @JSFunction
    init(_ body: String, _ options: JSObject) throws(JSException)
}

extension Response {
    static func json(_ value: some JSONEncodable) -> Response {
        do {
            let body = try NewJSONEncoder().encodeToString(value)
            return make(body: body, status: 200, contentType: "application/json; charset=utf-8")
        } catch {
            return Response(error: error)
        }
    }

    init(error: any Error, status: Int = 500) {
        self = Response.make(
            body: "\(error)",
            status: status,
            contentType: "text/plain; charset=utf-8"
        )
    }

    private static func make(body: String, status: Int, contentType: String) -> Response {
        try! Response(
            body,
            [
                "status": .number(Double(status)),
                "headers": .object(["content-type": .string(contentType)]),
            ])
    }
}
