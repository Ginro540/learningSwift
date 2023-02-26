//
//  GitHubCell.swift
//  LearningSwift
//
//  Created by 古賀貴伍社用 on 2023/02/27.
//

import Foundation
import UIKit

class GitHubCell : UITableViewCell {
    
    @IBOutlet private weak var name: UILabel!
    
    @IBOutlet private weak var desName: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func initCell(name: String, desName: String) {
        self.name.text = name
        self.desName.text = desName
    }
    
    
}
