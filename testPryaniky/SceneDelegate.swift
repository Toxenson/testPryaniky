//
//  SceneDelegate.swift
//  testPryaniky
//
//  Created by Тоха on 21.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        window?.rootViewController = MainViewController()
    }
}

