enum RandomMessageGenerator {
    private static let adjectives = [
        "pretty", "large", "big", "small", "tall", "short", "long",
        "handsome", "plain", "quaint", "clean", "elegant", "easy", "angry",
        "crazy", "helpful", "mushy", "odd", "unsightly", "adorable",
        "important", "inexpensive", "cheap", "expensive", "fancy",
    ]

    private static let colors = [
        "red", "yellow", "blue", "green", "pink", "brown", "purple", "brown",
        "white", "black", "orange",
    ]

    private static let nouns = [
        "table", "chair", "house", "bbq", "desk", "car", "pony", "cookie",
        "sandwich", "burger", "pizza", "mouse", "keyboard",
    ]

    static func generate(count: Int) -> [String] {
        (0..<count).map { _ in
            "\(adjectives.randomElement()!) "
                + "\(colors.randomElement()!) "
                + "\(nouns.randomElement()!)"
        }
    }
}
