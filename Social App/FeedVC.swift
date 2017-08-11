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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var navigationView: CustomView!
    @IBOutlet weak var postButton: CustomButton!
    @IBOutlet weak var chouseImage: CustomImmageView!
    @IBOutlet weak var descrTextField: CustomTextField!
    @IBOutlet weak var profileImage: CustomImmageView!

    @IBOutlet weak var logoutBtn: CustomButton!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var imageSelected = false
    var posts = [Post]()
    var imagePicker: UIImagePickerController!
    
    static var immageCache: NSCache <NSString, UIImage> = NSCache()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
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
            
            if let img = FeedVC.immageCache.object(forKey: post.postUrl as NSString) {
                cell.configureCell(post: post, img: img)
                return cell
            } else {
                cell.configureCell(post: post)
                return cell
            }
            
        } else {
        return PostCell()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.imageSelected = true
            chouseImage.image = image
        }else {
            print("KOt : image was not selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectImageTaped(_ sender: Any) {
        
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func postButtonPressed(_ sender: CustomButton) {
        
        guard let caption = self.descrTextField.text, caption != "" else {
            print("Kot: Input any caption here")
            return
        }
        guard let image = chouseImage.image,  self.imageSelected == true else {
            print("KOT: You should  Select the image")
            return
        }
        if let imageData = UIImageJPEGRepresentation(image, 0.2) {
            
            let immageUid = NSUUID().uuidString
            let metaData = StorageMetadata()
            metaData.contentType = "immage/jpeg"
            
            DataService.ds.REF_POSTS_IMAGES.child(immageUid).putData(imageData, metadata: metaData, completion: { (metadata, error) in
                if error != nil {
                    print("Kot: Tha image do not load to firebase")
                } else {
                    print("Kot: Sucesfuly download Data to firebase")
                    let downloadUrl = metadata?.downloadURL()?.absoluteString
                    if let url = downloadUrl {
                        self.postToFireBase(imageUrl: url)
                    }
                    
                }
                
            })
        }
        
    }
    
    func postToFireBase(imageUrl: String) {
        let post: Dictionary<String, Any> = [
        "caption": descrTextField.text!,
        "imageUrl": imageUrl,
        "likes": 0
        ]
        let fireBasePost = DataService.ds.REF_POSTS.childByAutoId()
        fireBasePost.setValue(post)
        
        self.descrTextField.text = ""
        self.imageSelected = false
        self.chouseImage.image = UIImage(named: "add-image")
        tableView.reloadData()
    }
    

    @IBAction func logoutButtton(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "GoBackToLogin", sender: nil)
        let keyChainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("Kot: Logjut and delete key from Keychain \(keyChainResult)")
        try! Auth.auth().signOut()
        
        
    }

}
