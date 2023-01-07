//
//  SceneDelegate.swift
//  projet_mobiledev
//
//  Created by user231762 on 1/7/23.
//
import UIKit
import Foundation
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: ContentScheduleView())
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    // ...
}
