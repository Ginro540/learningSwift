//
//  TableViewController.swift
//  LearningSwift
//
//  Created by 古賀貴伍社用 on 2023/02/23.
//

import Foundation
import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var item: SearchTableSectionModel?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // View初期化
        self.initView()
    }

    func initView(){
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        self.tableView.register(UINib(nibName: R.nib.gitHubCell.name, bundle: nil), forCellReuseIdentifier:  R.nib.gitHubCell.identifier)
    }
    
    func reload(item: SearchTableSectionModel){
        self.item = item
        self.tableView.reloadData()
    }
    
}

extension TableViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.gitHubCell.identifier) as! GitHubCell
        cell.initCell(name: item?.items[indexPath.row].name ?? "", desName: item?.items[indexPath.row].description ?? "")
        return cell
    }
}

extension TableViewController: UISearchBarDelegate {
    
    // SearchBarで入力を検知
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard searchText.count >= 0 else {
            return
        }
        
        Task.detached {
            do {
                let url = "https://api.github.com/search/repositories?q=\(searchText)&sort=stars&page=0&per_page=0"
                let response = try await GitHubAPI<SearchTableSectionModel>().request(with: url)
                await self.reload(item: response)
                print(response)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
