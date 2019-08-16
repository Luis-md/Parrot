// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

internal protocol StoryboardType {
  static var storyboardName: String { get }
}

internal extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: Bundle(for: BundleToken.self))
  }
}

internal struct SceneType<T: Any> {
  internal let storyboard: StoryboardType.Type
  internal let identifier: String

  internal func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal struct InitialSceneType<T: Any> {
  internal let storyboard: StoryboardType.Type

  internal func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal protocol SegueType: RawRepresentable { }

internal extension UIViewController {
  func perform<S: SegueType>(segue: S, sender: Any? = nil) where S.RawValue == String {
    let identifier = segue.rawValue
    performSegue(withIdentifier: identifier, sender: sender)
  }
}

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
internal enum StoryboardScene {
  internal enum AmizadeStoryboard: StoryboardType {
    internal static let storyboardName = "AmizadeStoryboard"

    internal static let amizadeViewController = SceneType<Treinamento_iOS.AmizadeViewController>(storyboard: AmizadeStoryboard.self, identifier: "AmizadeViewController")

    internal static let notificacaoViewController = SceneType<Treinamento_iOS.NotificacaoViewController>(storyboard: AmizadeStoryboard.self, identifier: "NotificacaoViewController")
  }
  internal enum LaunchScreen: StoryboardType {
    internal static let storyboardName = "LaunchScreen"

    internal static let initialScene = InitialSceneType<UIViewController>(storyboard: LaunchScreen.self)
  }
  internal enum Main: StoryboardType {
    internal static let storyboardName = "Main"

    internal static let initialScene = InitialSceneType<UINavigationController>(storyboard: Main.self)

    internal static let cadastroViewController = SceneType<Treinamento_iOS.CadastroViewController>(storyboard: Main.self, identifier: "CadastroViewController")

    internal static let viewController = SceneType<Treinamento_iOS.ViewController>(storyboard: Main.self, identifier: "ViewController")
  }
  internal enum Perfil: StoryboardType {
    internal static let storyboardName = "Perfil"

    internal static let editPerfilViewController = SceneType<Treinamento_iOS.EditPerfilViewController>(storyboard: Perfil.self, identifier: "EditPerfilViewController")

    internal static let perfilUserViewController = SceneType<Treinamento_iOS.PerfilUserViewController>(storyboard: Perfil.self, identifier: "PerfilUserViewController")

    internal static let perfilViewController = SceneType<Treinamento_iOS.PerfilViewController>(storyboard: Perfil.self, identifier: "PerfilViewController")
  }
  internal enum PostStoryboard: StoryboardType {
    internal static let storyboardName = "PostStoryboard"

    internal static let editViewController = SceneType<Treinamento_iOS.EditViewController>(storyboard: PostStoryboard.self, identifier: "EditViewController")

    internal static let postTabBarViewController = SceneType<Treinamento_iOS.PostTabBarViewController>(storyboard: PostStoryboard.self, identifier: "PostTabBarViewController")

    internal static let postViewController = SceneType<Treinamento_iOS.PostViewController>(storyboard: PostStoryboard.self, identifier: "PostViewController")
  }
}

internal enum StoryboardSegue {
}
// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

private final class BundleToken {}
