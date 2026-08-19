import ElementaryUI
import JavaScriptEventLoop
import JavaScriptKit
import NewCodable
import _Concurrency

@View
struct ContentView {
    @State var message = "The server has not been called yet."
    @State var isLoading = false

    var body: some View {
        main(
            .style([
                "font-family": "system-ui, sans-serif",
                "max-width": "42rem",
                "margin": "5rem auto",
                "padding": "0 1.5rem",
            ])
        ) {
            h1 { "Swift full-stack greeting" }
            p { message }

            if isLoading {
                button(.disabled) { "Loading…" }
            } else {
                button { "Ask the Swift Worker" }
                    .onClick { loadGreeting() }
            }
        }
    }

    func loadGreeting() {
        isLoading = true

        Task {
            defer { isLoading = false }

            do {
                let greeting = try await fetchGreetingJSON()
                message = greeting.message
            } catch {
                message = "Request failed: \(error)"
            }
        }
    }

    func fetchGreetingJSON() async throws -> Greeting {
        let result = try await fetch("/api/greeting")
        return try await result.decode(as: Greeting.self)
    }
}
