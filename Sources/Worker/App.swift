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
    let method: String
    let url: URL
    let path: String
    do {
        method = try request.method
        url = try URL(request.url)
        path = try url.pathname
    } catch {
        return Response.error("\(error)", status: 400)
    }

    switch (method, path) {
    case ("POST", "/api/greetings"):
        return await createGreeting(request)
    case ("GET", "/api/random-rows"):
        return randomRows(url)
    default:
        return Response.error("", status: 404)
    }
}

private func createGreeting(_ request: Request) async -> Response {
    do {
        let bytes = try await request.bytes()
        let input = try NewJSONDecoder().decode(
            GreetingRequest.self,
            from: bytes.span.bytes
        )

        guard !input.name.isEmpty, input.name.count <= 100 else {
            return Response.error("name must contain between 1 and 100 characters", status: 400)
        }

        return Response.json(
            GreetingResponse(
                message: "Hello, \(input.name), from a Swift Cloudflare Worker!",
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

    guard (1...100).contains(count) else {
        return Response.error("count must be between 1 and 100", status: 400)
    }

    let rows = (1...count).map { _ in randomRow() }
    return Response.json(RandomRowsResponse(rows: rows))
}

private func randomRow() -> String {
    let adjectives = ["pretty", "large", "small", "tall", "short", "elegant", "helpful"]
    let colors = ["red", "yellow", "blue", "green", "pink", "purple", "orange"]
    let nouns = ["table", "chair", "house", "desk", "car", "pony", "pizza"]

    return "\(adjectives.randomElement()!) \(colors.randomElement()!) \(nouns.randomElement()!)"
}
