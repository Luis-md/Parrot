// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
internal enum L10n {

  internal enum Common {
    /// Cancelar
    internal static let cancel = L10n.tr("Localizable", "common.cancel")
    /// Deletar post
    internal static let delPost = L10n.tr("Localizable", "common.delPost")
    /// O que deseja?
    internal static let deseja = L10n.tr("Localizable", "common.deseja")
    /// Editar post
    internal static let edtPost = L10n.tr("Localizable", "common.edtPost")
    /// Ok
    internal static let ok = L10n.tr("Localizable", "common.ok")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
