import NewCodable

// NOTE: the reason this is symlinked and not a shared target is this here:
// https://github.com/swiftlang/sourcekit-lsp/issues/2696

@JSONCodable
public struct GreetingRequest: Sendable, Equatable {
    public var name: String

    public init(name: String) {
        self.name = name
    }
}

@JSONCodable
public struct GreetingResponse: Sendable, Equatable {
    public var message: String
    public var number: Int

    public init(message: String, number: Int) {
        self.message = message
        self.number = number
    }
}

@JSONCodable
public struct RandomRowsResponse: Sendable, Equatable {
    public var rows: [String]

    public init(rows: [String]) {
        self.rows = rows
    }
}
