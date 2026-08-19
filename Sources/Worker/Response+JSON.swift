import JavaScriptKit

extension Response {
    static func json(
        _ body: String,
        status: Int = 200
    ) -> Response {
        make(
            body: body,
            status: status,
            contentType: "application/json; charset=utf-8"
        )
    }

    init(
        error: any Error,
        status: Int = 500
    ) {
        self = Response.make(
            body: "\(error)",
            status: status,
            contentType: "text/plain; charset=utf-8"
        )
    }

    private static func make(
        body: String,
        status: Int,
        contentType: String
    ) -> Response {
        let headers = JSObject()
        headers["content-type"] = contentType.jsValue

        let options = JSObject()
        options["status"] = .number(Double(status))
        options["headers"] = headers.jsValue

        do {
            return try Response(body, options)
        } catch {
            fatalError("Could not construct a JavaScript Response: \(error)")
        }
    }
}
