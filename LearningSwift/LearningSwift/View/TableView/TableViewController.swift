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
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    private var item: SearchTableSectionModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // View初期化
        self.initView()
        // 戻るボタン
        self.initBackButton()
    }

    func initView(){
        indicatorView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        self.tableView.register(UINib(nibName: R.nib.gitHubCell.name, bundle: nil), forCellReuseIdentifier:  R.nib.gitHubCell.identifier)
    }
    
    func initBackButton() {
        let chevronLeftImage: UIImage? = UIImage(systemName: "chevron.left")
        let backButton = UIBarButtonItem(image: chevronLeftImage, style: .plain, target: self, action: #selector(onTapBackButton(_:)))
        navigationItem.leftBarButtonItem = backButton
    }
    
    func indicatorControl(hiddon: Bool){
        if hiddon {
            self.indicatorView.isHidden = false
            self.indicatorView.startAnimating()
        } else {
            self.indicatorView.isHidden = true
            self.indicatorView.stopAnimating()
        }
    }
    
    @objc func onTapBackButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    func reload(item: SearchTableSectionModel){
        self.item = item
        self.tableView.reloadData()
    }
    
    func emptyReload(){
        self.item = nil
        self.tableView.reloadData()
    }
    
}

extension TableViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.gitHubCell.identifier) as! GitHubCell
        cell.initCell(name: item?.items[indexPath.row].name ?? "", desName: item?.items[indexPath.row].description ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let item = item?.items[indexPath.row] else {
            return
        }
        
        let storyboad = UIStoryboard(name: R.storyboard.gitHubDetail.name, bundle: nil).instantiateInitialViewController() as! GitHubDetailView
        storyboad.item = item
        self.present(storyboad, animated: true)
    }
}

extension TableViewController: UISearchBarDelegate {
    
    // SearchBarで入力を検知
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // サーチバーで何も入力されてない場合は処理しない
        guard searchText.count >= 0,
        !searchText.isEmpty  else {
            emptyReload()
            return
        }
        
        Task.detached {
            do {
                await self.indicatorControl(hiddon: true)
                let url = "https://api.github.com/search/repositories?q=\(searchText)&sort=stars&page=0&per_page=0"
                let response = try await GitHubAPI<SearchTableSectionModel>().request(with: url)
                await self.reload(item: response)
                print(response)
            } catch {
                print(error.localizedDescription)
            }
            await self.indicatorControl(hiddon: false)
        }
        
        
        
    }
}
