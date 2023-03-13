//
//  GitHubDetailView.swift
//  LearningSwift
//
//  Created by 古賀貴伍社用 on 2023/03/12.
//

import Foundation
import UIKit

class GitHubDetailView: UIViewController {
    
    var item : Repository?
    
    @IBOutlet weak var descrip: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let item = self.item else {
            return
        }
        self.descrip.text = item.description
        self.name.text = item.name
        self.navigationItem.title = item.name
    }
}
