import ElementaryUI
import _Concurrency

@View
struct ContentView {
    var body: some View {
        main {
            header {
                p { "ElementaryUI × Cloudflare" }
                h1 { "Full-Stack Swift Demo" }
                p { "Swift in the browser. Swift on the edge." }
            }

            div {
                GreetingView()
                RandomRowsView()
            }

            footer {
                p {
                    "Demo of "
                    a(.href("https://elementary.codes")) { "ElementaryUI" }
                    ", "
                    a(.href("https://github.com/swiftwasm/JavaScriptKit")) { "BridgeJS" }
                    ", and "
                    a(
                        .href(
                            "https://github.com/swiftlang/swift-foundation/tree/experimental/new-codable"
                        )
                    ) { #""NewCodable""# }
                    " using Embeded Swift - running in your browser and on Cloudflare Workers. "
                    a(.href("https://github.com/elementary-swift/example-cloudflare-worker")) {
                        "View the source on GitHub."
                    }
                }
            }
        }
    }
}

@View
struct GreetingView {
    @State var name = "Stranger"
    @State var greeting = "The server has not been called yet."
    @State var isLoading = false

    var body: some View {
        section {
            p { "Greeting" }
            h2 { "Call Swift on the server" }

            label {
                span { "Your name" }
                input(.type(.text))
                    .bindValue($name)
            }

            button { "Create greeting" }
                .attributes(.disabled, when: isLoading)
                .onClick { createGreeting() }

            p { greeting }
        }
    }

    func createGreeting() {
        isLoading = true

        Task {
            defer { isLoading = false }

            do {
                let response = try await fetch(
                    "/api/greetings",
                    json: GreetingRequest(name: name),
                    as: GreetingResponse.self
                )
                greeting = "\(response.message) Lucky number: \(response.number)."
            } catch {
                greeting = "Request failed: \(error)"
            }
        }
    }
}

@View
struct RandomRowsView {
    @State var rowCount = 5
    @State var rows: [String] = []
    @State var status = "Choose how many rows to fetch."
    @State var isLoading = false

    var body: some View {
        section {
            p { "Random rows" }
            h2 { "Fetch rows from the server" }

            label {
                span { "Number of rows" }
                input(
                    .type(.number),
                    .min(1),
                    .max(10000),
                    .step(1)
                )
                .bindValue($rowCount)
            }

            button { "Fetch random rows" }
                .attributes(.disabled, when: isLoading)
                .onClick { loadRows() }

            p { status }

            if !rows.isEmpty {
                ul {
                    ForEach(rows.indices, key: { String($0) }) { index in
                        li { rows[index] }
                    }
                }
            }
        }
    }

    func loadRows() {
        let count = rowCount

        isLoading = true

        Task {
            defer { isLoading = false }

            do {
                let response = try await fetch(
                    "/api/random-rows?count=\(count)",
                    as: RandomRowsResponse.self
                )
                status = "Fetched \(count) random rows from the Swift Worker."
                rows = response.rows
            } catch {
                status = "Request failed: \(error)"
            }
        }
    }
}

extension View where Tag == HTMLTag.input {
    func bindValue(_ value: Binding<Int>) -> some View<Tag> {
        self.bindValue(
            Binding<Double?>(
                get: { Double(value.wrappedValue) },
                set: { count in value.wrappedValue = Int(count ?? 0) }
            ))
    }
}
