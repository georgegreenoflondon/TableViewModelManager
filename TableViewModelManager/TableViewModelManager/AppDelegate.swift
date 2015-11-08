//
//  AppDelegate.swift
//  TableViewModelManager
//
//  Created by George Green on 08/11/2015.
//  Copyright © 2015 George Green of London. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		// Setup the window and the root view controller
		window = UIWindow(frame: UIScreen.mainScreen().bounds)
		window!.rootViewController = ViewController()
		window!.makeKeyAndVisible()
		// Return
		return true
	}

}

