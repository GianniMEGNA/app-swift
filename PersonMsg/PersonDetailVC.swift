//
//  PersonDetailVC.swift
//  PersonMsg
//
//  Created by Gianni MEGNA on 09/08/2019.
//  Copyright © 2019 Gianni MEGNA. All rights reserved.
//

import UIKit

class PersonDetailVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    
    var person: Person?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = person?.name
        usernameLabel.text = person?.username
        emailLabel.text = person?.email
        phoneLabel.text = person?.phone
        websiteLabel.text = person?.website
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
