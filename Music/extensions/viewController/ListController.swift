//
//  ListController.swift
//  CamDigiKey
//
//  Created by Sann Chhailong on 12/26/18.
//  Copyright © 2018 Sann Chhailong. All rights reserved.
//

import UIKit

/**
 Convenient list component where a Header class is not required.
 
 ## Generics ##
 T: the cell type that this list will register and dequeue.
 
 U: the item type that each cell will visually represent.
 */

@available(iOS 11.0, tvOS 11.0, *)
open class ListController<T: ListCell<U>, U>: UIViewController, UITableViewDelegate, UITableViewDataSource{
      /// An array of U objects this list will render. When using items.append, you still need to manually call reloadData.
      open var items = [U]() {
            didSet {
                  DispatchQueue.main.async {
                        self.tableView.reloadData()
                  }
            }
      }
      
      
      open var tableView: UITableView!
      init() {
            super.init(nibName: nil, bundle: nil)
            self.tableView = UITableView()
      }
      
      required public init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
      }
      
      
      let cellId = "cellId"
      open override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .systemBackground
            navigationController?.navigationBar.prefersLargeTitles = true
            self.tableView.delegate = self
            self.tableView.dataSource = self
            
            self.tableView.register(T.self, forCellReuseIdentifier: cellId)
            
            view.addSubview(self.tableView)
            self.tableView.fillSuperview()
            self.navigationController?.navigationBar.tintColor = .accentColor
      }
      open  func numberOfSections(in tableView: UITableView) -> Int {
            1
      }
      open  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! T
            cell.item = items[indexPath.row]
            return cell
      }
      open  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            items.count
      }
}
