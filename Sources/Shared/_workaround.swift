import NewCodable

extension NewJSONEncoder {
    func encodeToString(_ value: some JSONEncodable) throws(CodingError.Encoding) -> String {
        // NOTE: written like this to avoid embedded crahser, see https://github.com/swiftlang/swift-foundation/issues/2193
        let data = try self.encode(value)

        let result = String(copying: data)

        let (storage, _) = data.deconstruct()
        storage.deallocate()

        return result
    }
}

extension String {
    fileprivate init(copying bytes: borrowing GrowableEncodingBytes) {
        self.init(copying: UTF8Span(unchecked: bytes.span))
    }
}
