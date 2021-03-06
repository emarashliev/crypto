import CCryptoOpenSSL

/// An error encountered while working with crypto.
public struct CryptoError: Error {
    /// See `Debuggable.identifier`
    public var identifier: String

    /// See `Debuggable.reason`
    public var reason: String

    /// Internal error creation from OpenSSL
    internal static func openssl(identifier: String, reason: String) -> CryptoError {
        let errmsg = ERR_error_string(ERR_get_error(), nil)

        let cReason: String
        if let e = errmsg {
            cReason = String(validatingUTF8: e) ?? "unknown (invalid error message UTF8)"
        } else {
            cReason = "unknown"
        }

        return .init(identifier: identifier, reason: "\(reason): \(cReason).")
    }
    
    /// Custom Crypto errors
    internal static func custom(identifier: String, reason: String) -> CryptoError {
        return .init(identifier: identifier, reason: reason)
    }
}
