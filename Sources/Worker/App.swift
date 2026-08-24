import JavaScriptEventLoop
import JavaScriptKit
import NewCodable

@main
struct CloudflareWorker {
    static func main() {
        JavaScriptEventLoop.installGlobalExecutor()
    }
}

@JS func fetch(_ request: Request) async -> Response {
    guard let method = try? request.method,
        let url = try? URL(request.url),
        let path = try? url.pathname
    else {
        return Response.error("unexpected error")
    }

    switch (method, path) {
    case ("POST", "/api/greetings"):
        return await createGreeting(request)
    case ("GET", "/api/random-rows"):
        return randomRows(url)
    default:
        return Response.notFound
    }
}

private func createGreeting(_ request: Request) async -> Response {
    do {
        let bytes = try await request.bytes()
        var input = try NewJSONDecoder().decode(
            GreetingRequest.self,
            from: bytes.span.bytes
        )

        if input.name.isEmpty {
            input.name = "Stranger"
        }

        return Response.json(
            GreetingResponse(
                message: "Hello there, \(input.name)! The cloud greets you.",
                number: Int.random(in: 1...100)
            )
        )
    } catch {
        return Response.error("\(error)", status: 400)
    }
}

private func randomRows(_ url: URL) -> Response {
    let count: Int
    let parameters = try? url.searchParams
    guard let value = try? parameters?.get("count"), let parsedCount = Int(value) else {
        return Response.error("count must be a number", status: 400)
    }
    count = parsedCount

    guard (0...10000).contains(count) else {
        return Response.error("count must be between 0 and 10000", status: 400)
    }

    let rows = (0..<count).map { _ in randomRow() }
    return Response.json(RandomRowsResponse(rows: rows))
}

private func randomRow() -> String {
    let adjectives = ["pretty", "large", "small", "tall", "short", "elegant", "helpful"]
    let colors = ["red", "yellow", "blue", "green", "pink", "purple", "orange"]
    let nouns = ["table", "chair", "house", "desk", "car", "pony", "pizza"]

    return "\(adjectives.randomElement()!) \(colors.randomElement()!) \(nouns.randomElement()!)"
}
