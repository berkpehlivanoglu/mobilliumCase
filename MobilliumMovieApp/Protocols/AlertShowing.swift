//
//  AlertShowing.swift
//  MobilliumMovieApp
//
//  Created by Berk Pehlivanoğlu on 4.10.2022.
//

import UIKit

protocol AlertShowing: AnyObject {

    func showAlert(title: String?, message: String?, actionTitle: String, _ actionHandler: (() -> Void)?)

}

enum AlertType {
    case info
    case warning
    case error
    case success
}

enum AlertButtonType: String {
    case ok
    case cancel
    case yes
    case no

    var localized: String {
        switch self {
        case .ok:
            return Strings.ok
        case .cancel:
            return Strings.cancel
        case .yes:
            return Strings.yes
        case .no:
            return Strings.no
        }
    }
}

extension AlertShowing where Self: UIViewController {

    func showAlert(title: String?, message: String?, actionTitle: String = "OK", _ actionHandler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { _ in
            actionHandler?()
        }
        alert.addAction(action)
        let topVc = UIApplication.topViewController() ?? self
        topVc.present(alert, animated: true)
    }

    func showAlertWithButtons(withType alertType: AlertType? = .info, title: String? = "", message: String, buttons: [String]? = nil, completion: ((Int) -> Void)! = nil) {

        var defaultButtons: [String] = []

        defaultButtons = [AlertButtonType.ok.localized]

        let buttons = buttons ?? defaultButtons

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        buttons.enumerated().forEach { index, value in

            let action = UIAlertAction(title: value, style: .default) { _ in
                completion?(index)
            }

            alert.addAction(action)
        
        present(alert, animated: true)
    }

}

}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
