import JavaScriptKit

@JSClass(from: .global)
struct Request {
    @JSGetter var method: String
    @JSGetter var url: String
    @JSFunction func text() async throws(JSException) -> String
}

@JSClass(from: .global)
struct URL {
    @JSGetter var pathname: String
    @JSFunction init(_ input: String) throws(JSException)
}

@JSClass(from: .global)
struct Response {
    @JSFunction
    init(_ body: String, _ options: JSObject) throws(JSException)
}
