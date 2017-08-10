//
//  FeedVC.swift
//  Social App
//
//  Created by Мулярчук Константин on 10.08.17.
//  Copyright © 2017 healthAndFitnes. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var navigationView: CustomView!
    @IBOutlet weak var postButton: CustomButton!
    @IBOutlet weak var chouseImage: CustomImmageView!
    @IBOutlet weak var descrTextField: CustomTextField!
    @IBOutlet weak var profileImage: CustomImmageView!

    @IBOutlet weak var logoutBtn: CustomButton!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationView.configure()
        postButton.configureFace()
        chouseImage.configure()
        descrTextField.configure()
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    print("Snap: \(snap)")
                    if let postDict = snap.value as? Dictionary<String,Any> {
                        let key = snap.key
                        let post = Post.init(postId: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        })
        

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            cell.configureCell(post: post)
            return cell
        } else {
        return PostCell()
        }
    }
    
    

    @IBAction func logoutButtton(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "GoBackToLogin", sender: nil)
        let keyChainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("Kot: Logjut and delete key from Keychain \(keyChainResult)")
        try! Auth.auth().signOut()
        
        
    }

}
