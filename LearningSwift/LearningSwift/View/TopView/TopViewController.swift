//
//  TopViewController.swift
//  LearningSwift
//
//  Created by 古賀貴伍社用 on 2023/02/23.
//

import Foundation
import UIKit

class TopViewConroller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    
    @IBAction func tableViewButtonAction(_ sender: Any) {
        let storyboad = UIStoryboard(name: R.storyboard.tableViewController.name, bundle: nil).instantiateInitialViewController() as! UINavigationController
        storyboad.modalPresentationStyle = .fullScreen
        self.present(storyboad, animated: true)
        
        
        
    }
    
    @IBAction func collectionViewAction(_ sender: Any) {
        
        
        
        
    }
    
    
    
}
