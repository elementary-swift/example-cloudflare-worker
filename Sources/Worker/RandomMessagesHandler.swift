import JavaScriptKit
import NewCodable

enum RandomMessagesHandler {
    static func handle(
        _ request: Request
    ) async -> Response {
        let body: String
        do {
            body = try await request.text()
        } catch {
            return Response(error: error)
        }

        let input: RandomMessagesRequest
        do {
            input = try NewJSONDecoder().decode(
                RandomMessagesRequest.self,
                from: body.utf8Span
            )
        } catch {
            return Response(
                error: WorkerError.invalidRequestJSON,
                status: 400
            )
        }

        guard (0...10_000).contains(input.count) else {
            return Response(
                error: WorkerError.invalidMessageCount,
                status: 400
            )
        }

        let response = RandomMessagesResponse(
            messages: RandomMessageGenerator.generate(count: input.count)
        )

        do {
            let json = try NewJSONEncoder().encode(response) { bytes in
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
