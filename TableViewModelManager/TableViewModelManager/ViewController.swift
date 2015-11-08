//
//  ViewController.swift
//  TableViewModelManager
//
//  Created by George Green on 08/11/2015.
//  Copyright © 2015 George Green of London. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	// MARK: - Instance Variables
	
	let tableView = UITableView(frame: CGRectZero, style: .Plain)
	
	// MARK: - Object Lifecycle Methods
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	init() {
		super.init(nibName: nil, bundle: nil)
	}
	
	// MARK: - View Lifecycle Methods
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Add the table view as a subview
		view.addSubview(tableView)
	}
	
	override func viewWillLayoutSubviews() {
		tableView.frame = view.bounds
	}
	
}

