import ElementaryUI
import _Concurrency

@View
struct ContentView {
    @State var name = "Stranger"
    @State var greeting = "The server has not been called yet."
    @State var rowCount = 5
    @State var randomRows: [String] = []
    @State var randomRowsStatus = "Choose how many rows to fetch."
    @State var isLoadingGreeting = false
    @State var isLoadingRandomRows = false

    var body: some View {
        main {
            h1 { "A full-stack Swift web app" }

            section {
                h2 { "Call Swift on the server" }
                label {
                    "Your name "
                    input(.type(.text))
                        .bindValue($name)
                }
                p { greeting }

                if isLoadingGreeting {
                    button(.disabled) { "Loading…" }
                } else {
                    button { "Create Greeting" }
                        .onClick { createGreeting() }
                }
            }

            section {
                h2 { "Fetch random rows from the server" }
                label {
                    "Number of rows "
                    input(
                        .type(.number),
                        .custom(name: "min", value: "1"),
                        .custom(name: "max", value: "100"),
                        .custom(name: "step", value: "1")
                    )
                    .bindValue($rowCount)
                }

                if isLoadingRandomRows {
                    button(.disabled) { "Loading…" }
                } else {
                    button { "Fetch Random Rows" }
                        .onClick { loadRandomRows() }
                }

                p { randomRowsStatus }
                ul {
                    ForEach(randomRows.indices, key: { String($0) }) { index in
                        li { randomRows[index] }
                    }
                }
            }

            footer {
                p {
                    "This is an example of a full-stack Swift app using NewCodable in WebAssembly, running in your browser and on Cloudflare Workers. "
                    a(.href("https://github.com/elementary-swift/example-cloudflare-worker")) {
                        "See the source code on GitHub."
                    }
                }
            }
        }
    }

    func createGreeting() {
        isLoadingGreeting = true

        Task {
            defer { isLoadingGreeting = false }

            do {
                let response = try await fetch(
                    "/api/greetings",
                    json: GreetingRequest(name: name),
                    as: GreetingResponse.self
                )
                greeting = "\(response.message) The server picked \(response.number)."
            } catch {
                greeting = "Request failed: \(error)"
            }
        }
    }

    func loadRandomRows() {
        let count = rowCount
        guard (1...100).contains(count) else {
            randomRowsStatus = "Enter a whole number from 1 through 100."
            return
        }

        isLoadingRandomRows = true

        Task {
            defer { isLoadingRandomRows = false }

            do {
                let response = try await fetch(
                    "/api/random-rows?count=\(count)",
                    as: RandomRowsResponse.self
                )
                randomRowsStatus = "Fetched \(count) random rows from the Swift Worker."
                randomRows = response.rows
            } catch {
                randomRowsStatus = "Request failed: \(error)"
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
