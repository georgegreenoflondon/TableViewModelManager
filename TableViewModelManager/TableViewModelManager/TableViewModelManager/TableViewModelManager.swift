//
//  TableViewModelManager.swift
//  TableViewModelManager
//
//  Created by George Green on 08/11/2015.
//  Copyright © 2015 George Green of London. All rights reserved.
//

import UIKit

///
/// Objects used as models in the TableViewModelManager must conform to this protocol.
///

public protocol TableViewModelObject {
	
	///
	/// Indicates if the model object has changed and requires its cell to be updated
	/// when the manager next performs an update on the table.
	///
	
	var isDirty: Bool { get }
	
	///
	/// Used by the model manager to determine what has changed between the old model and the new.
	/// Function prototype matches that in `NSObjectProtocol` so any `NSObject` subclasses get this
	/// for free.
	///
	/// - parameter other: The object to which the reciever should be compared.
	///
	/// - returns: A `Bool` indicating if the two objects are the same.
	///
	
	func isEqual(other: AnyObject?) -> Bool
}

/// A data source for the model manager to provide the cells for the table view.
public protocol TableViewModelManagerDataSource {
	
	///
	/// Called on the data source when the underlying `UITableView` requires a cell for display.
	///
	/// - parameter manager: The `TableViewModelManager` instance requesting the cell.
	/// - parameter indexPath: The indexPath at which the cell will be displayed in the table view.
	/// - parameter modelObject: The `TableViewModelObject` instance that should be used to configure the cell.
	///
	/// - returns: A `UITableViewCell` subclass to be displayed by the table view.
	///
	/// - note: The manager is not responsible for ensuring that the cell class returned from this call has
	/// been properly registered with the table view, and for properly reusing cells. This must be handled externally.
	///
	
	func tableViewModelManager(manager: TableViewModelManager, cellForRowAtIndexPath indexPath: NSIndexPath, withModelObject modelObject: TableViewModelObject) -> UITableViewCell
}

///
/// Manager class keeps hold of the model for the table view and handles providing data to the table view
/// when it is requested.
/// Also handles detecting changes in the model and making appropriate update/insert/delete call to the 
/// table view to reflect the changes.
///

public class TableViewModelManager: NSObject, UITableViewDataSource {
	
	///
	/// The data type used by the manager to hold data about what will be displayed in the table view.
	///
	
	public typealias TableViewModel = [[TableViewModelObject]]
	
	///
	/// The underlying data model used to populate the table view.
	///
	
	private var tableModel: TableViewModel
	
	///
	/// The dataSource used by the manager to get additional required data.
	///
	
	public var dataSource: TableViewModelManagerDataSource
	
	///
	/// The `UITableView` object being manager by this instance.
	///
	
	public let tableView: UITableView
	
	// MARK: - Object Lifecycle Methods
	
	///
	/// Create a new instance of `TableViewModelManager` with a `UITableView` to manager and an initial
	/// model to use to populate it.
	///
	/// - parameter inTableView: The `UITableView` that will be managed by the new instance.
	/// - paraneter inInitialModel: An initial model to be used to provide data to the table view.
	/// If nil, a default empty model will be used.
	///
	
	public init(inTableView: UITableView, inDataSource: TableViewModelManagerDataSource, inInitialModel: TableViewModel?) {
		// Keep hold of the initialisation parameters
		tableView = inTableView
		dataSource = inDataSource
		tableModel = inInitialModel ?? TableViewModel()
		// Call super
		super.init()
		// Set self as the datasource on the table view
		tableView.dataSource = self
	}
	
	// MARK: - UITableViewDataSource Methods
	
	public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return tableModel.count
	}
	
	public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableModel[section].count
	}
	
	public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		return dataSource.tableViewModelManager(self, cellForRowAtIndexPath: indexPath, withModelObject: tableModel[indexPath.section][indexPath.row])
	}
	
}