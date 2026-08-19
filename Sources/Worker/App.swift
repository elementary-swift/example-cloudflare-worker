import JavaScriptEventLoop
import JavaScriptKit

@main
struct CloudflareWorker {
    static func main() {
        JavaScriptEventLoop.installGlobalExecutor()
    }
}

@JS func fetch(_ request: Request) async -> Response {
    let method: String
    let path: String
    do {
        method = try request.method
        path = try URL(request.url).pathname
    } catch {
        return Response(error: error)
    }

    switch (method, path) {
    case ("GET", "/api/greeting"):
        return GreetingHandler.handle()
    case ("POST", "/api/messages"):
        return await RandomMessagesHandler.handle(request)
    default:
        return Response(
            error: WorkerError.notFound,
            status: 404
        )
    }
}
