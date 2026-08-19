import JavaScriptKit
import NewCodable

enum GreetingHandler {
    static func handle() -> Response {
        let greeting = Greeting(
            message: "Hello from a Swift Cloudflare Worker!"
        )

        do {
            let json = try NewJSONEncoder().encode(greeting) { bytes in
                bytes.withUnsafeBytes {
                    String(decoding: $0, as: UTF8.self)
                }
            }
            return Response.json(json)
        } catch {
            return Response(error: error)
        }
    }
}
