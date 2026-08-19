import NewCodable

// NOTE: the reason this is symlinked and not a shared target is this here:
// https://github.com/swiftlang/sourcekit-lsp/issues/2696

@JSONCodable
public struct Greeting: Sendable, Equatable {
    public let message: String

    public init(message: String) {
        self.message = message
    }
}

@JSONCodable
public struct RandomMessagesRequest: Sendable, Equatable {
    public let count: Int

    public init(count: Int) {
        self.count = count
    }
}

@JSONCodable
public struct RandomMessagesResponse: Sendable, Equatable {
    public let messages: [String]

    public init(messages: [String]) {
        self.messages = messages
    }
}
