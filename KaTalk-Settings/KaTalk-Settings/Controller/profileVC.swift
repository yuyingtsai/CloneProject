//
//  profileVC.swift
//  KaTalk-Settings
//
//  Created by Peichun Tsai on 2018/3/19.
//  Copyright © 2018年 Peichun Tsai. All rights reserved.
//

import UIKit

class profileVC: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
 
  //  let imageHeader =  UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 130))
    let sectionView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3))
    let imageHeader = UIImageView()
//    let profileImage = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 45, y: 85, width: 90, height: 90))
let profileImage = UIImageView()

    var choosedTag = 0

//    let nameLabel = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.height / 3.3, width: UIScreen.main.bounds.width / 1.9, height: 20))
   let nameLabel = UILabel()

//    let editIconImage = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width / 2 + 10, y: UIScreen.main.bounds.height / 3.3 , width: 20, height: 20))
let editIconImage = UIImageView()
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Edit Profile"
        nameLabel.text = "Ryan"
        print(UIScreen.main.bounds.width)
        print(UIScreen.main.bounds.height)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = userDefaults.string(forKey: "saveName")
    }
    

    
    // When tapped -- Header pic is tapped
    @objc func sectionHeaderTapped() {
        
        //選取提示框 -- Header part
        let picker = UIImagePickerController()

        choosedTag = 0
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let fromGallery = UIAlertAction(title: "Choose from Gallery", style: .default) { (Gallery) in
            picker.sourceType = .photoLibrary
            picker.delegate = self
            self.show(picker, sender: self)
        }
        
        let fromKaTalk = UIAlertAction(title: "Choose from KakaoTalk Cheez", style: .default) { (KaTalk) in
            print("From KakaoTalk")
        }
        
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel) { (cancelAction) in
            picker.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(fromGallery)
        alert.addAction(fromKaTalk)
        alert.addAction(cancelBtn)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    // When tapped - Profile Image tapped
    @objc func profileImageTapped() {
        
        //選取提示框 -- Profile Image part
        let picker = UIImagePickerController()
        
        choosedTag = 1
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let fromGallery = UIAlertAction(title: "Choose from Gallery", style: .default) { (Gallery) in
            picker.sourceType = .photoLibrary
            picker.delegate = self
            self.show(picker, sender: self)
        }
        
        let fromKaTalk = UIAlertAction(title: "Choose from KakaoTalk Cheez", style: .default) { (KaTalk) in
            print("From KakaoTalk")
        }
        
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel) { (cancelAction) in
            picker.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(fromGallery)
        alert.addAction(fromKaTalk)
        alert.addAction(cancelBtn)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func nameLabelTapped() {
        let nameVC = UIStoryboard.init(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "nameVC") as! NameVC
        self.navigationController?.pushViewController(nameVC, animated: true)

    }
    

    
    // replace header pic which user choosed
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage

        if choosedTag == 0 {
            imageHeader.image = image
            imageHeader.contentMode = .scaleAspectFill
            imageHeader.clipsToBounds = true
            dismiss(animated: true, completion: nil)
        }
        else {
            profileImage.image = image
            profileImage.contentMode = .scaleAspectFill
            profileImage.clipsToBounds = true
            dismiss(animated: true, completion: nil)
        }
    }
  
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return UIScreen.main.bounds.height  / 3

        } else {
            return 10.0
        }
    }

    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        if section == 0 {
            
            
            
            // ADD - image autolayout
            sectionView.backgroundColor = UIColor.groupTableViewBackground
            sectionView.addSubview(imageHeader)
            imageHeader.image = UIImage(named: "pic")
            imageHeader.contentMode = .scaleAspectFill
            imageHeader.clipsToBounds = true
            
            imageHeader.translatesAutoresizingMaskIntoConstraints = false
            imageHeader.topAnchor.constraint(equalTo: sectionView.topAnchor).isActive = true
            imageHeader.leftAnchor.constraint(equalTo: sectionView.leftAnchor).isActive = true
            imageHeader.rightAnchor.constraint(equalTo: sectionView.rightAnchor).isActive = true
            imageHeader.heightAnchor.constraint(equalTo: sectionView.heightAnchor, multiplier: 0.55).isActive = true
            
            
            // ADD - profile autolayout
            sectionView.addSubview(profileImage)
            profileImage.image = UIImage(named: "icons8-customer-100-2")
            profileImage.contentMode = .scaleAspectFit
            profileImage.clipsToBounds = true
      
            profileImage.translatesAutoresizingMaskIntoConstraints = false
            profileImage.centerYAnchor.constraint(equalTo: imageHeader.bottomAnchor).isActive = true
            profileImage.centerXAnchor.constraint(equalTo: sectionView.centerXAnchor).isActive = true
            profileImage.heightAnchor.constraint(equalToConstant: 105).isActive = true
            //profileImage.heightAnchor.constraint(equalTo: sectionView.heightAnchor, multiplier: 0.4).isActive = true
            profileImage.widthAnchor.constraint(equalToConstant: 105).isActive = true
            //profileImage.widthAnchor.constraint(equalTo: sectionView.heightAnchor, multiplier: 0.4).isActive = true
            profileImage.layoutIfNeeded()
            profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
      
            
            // ADD - name label autolayout
            sectionView.addSubview(nameLabel)
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            
            //nameLabel.rightAnchor.constraint(equalTo: sectionView.centerXAnchor, constant: 5).isActive = true
            nameLabel.centerXAnchor.constraint(equalTo: sectionView.centerXAnchor, constant: 0).isActive = true
            nameLabel.centerYAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20).isActive = true
            
            nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
           // nameLabel.textAlignment = .center
            
            
            // ADD - edit icon image
            sectionView.addSubview(editIconImage)
            editIconImage.image = UIImage(named: "icons8-edit-64")?.withRenderingMode(.alwaysTemplate)
            editIconImage.tintColor = .gray
            editIconImage.contentMode = .scaleAspectFit
            editIconImage.translatesAutoresizingMaskIntoConstraints = false
            editIconImage.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 3).isActive = true
            
            editIconImage.centerYAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20).isActive = true
            
            editIconImage.heightAnchor.constraint(equalToConstant: 15).isActive = true
            editIconImage.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
            
            // Add tap gesture - Header Picture
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sectionHeaderTapped))
            
            // Add tap gesture - Profile Picture
            let tapProfileGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        
            // Add tap gesture - Name Label
            let tapLabelGesture = UITapGestureRecognizer(target: self, action: #selector(nameLabelTapped))
            
            // Add tap gesture - Icon Image
            let tapEditIconGesture = UITapGestureRecognizer(target: self, action: #selector(nameLabelTapped))
            
            imageHeader.isUserInteractionEnabled = true
            imageHeader.addGestureRecognizer(tapGesture)
            profileImage.isUserInteractionEnabled = true
            profileImage.addGestureRecognizer(tapProfileGesture)
            nameLabel.isUserInteractionEnabled = true
            nameLabel.addGestureRecognizer(tapLabelGesture)
            editIconImage.isUserInteractionEnabled = true
            editIconImage.addGestureRecognizer(tapEditIconGesture)
      
            return sectionView
            
            


//
//            nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
//            nameLabel.textAlignment = .right
//
//            editIconImage.image = UIImage(named: "icons8-edit-64")?.withRenderingMode(.alwaysTemplate)
//            editIconImage.contentMode = .scaleAspectFit
//            editIconImage.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//
//
//            // Add tap gesture - Header Picture
//            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sectionHeaderTapped))
//
//            // Add tap gesture - Profile Picture
//            let tapProfileGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
//
//            // Add tap gesture - Name Label
//            let tapLabelGesture = UITapGestureRecognizer(target: self, action: #selector(nameLabelTapped))
//
//            // Add tap gesture - Icon Image
//            let tapEditIconGesture = UITapGestureRecognizer(target: self, action: #selector(nameLabelTapped))
//
//            imageHeader.isUserInteractionEnabled = true
//            imageHeader.addGestureRecognizer(tapGesture)
//            profileImage.isUserInteractionEnabled = true
//            profileImage.addGestureRecognizer(tapProfileGesture)
//            nameLabel.isUserInteractionEnabled = true
//            nameLabel.addGestureRecognizer(tapLabelGesture)
//            editIconImage.isUserInteractionEnabled = true
//            editIconImage.addGestureRecognizer(tapEditIconGesture)
//
//
//            tableView.tableHeaderView = imageHeader
            
         //   self.view.addSubview(imageHeader)
//            self.view.addSubview(profileImage)
//            self.view.addSubview(nameLabel)
//            self.view.addSubview(editIconImage)
       //     tableView.tableHeaderView = myView
//myView.addSubview(imageHeader)
         //   imageHeader.translatesAutoresizingMaskIntoConstraints = false
           // imageHeader.centerYAnchor.constraint(equalTo: )
//
//            // Autolayout - Profile picture
//            profileImage.translatesAutoresizingMaskIntoConstraints = false
//            profileImage.centerYAnchor.constraint(equalTo: imageHeader.bottomAnchor).isActive = true
//            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//            //在這裡重新 layout 一次，否則此時 profileImage.frame.size.width / 2 還算不出來
//            profileImage.layoutIfNeeded()
//            profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
//            profileImage.layer.masksToBounds = true
//
//            profileImage.widthAnchor.constraint(equalTo: profileImage.heightAnchor).isActive = true
////            profileImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
//
//            // Autolayout - nameLabel
//            nameLabel.translatesAutoresizingMaskIntoConstraints = false
//            nameLabel.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
//            nameLabel.centerYAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 35).isActive = true
//            nameLabel.textAlignment = .right
//
//            // Autolayout - Icon
//            editIconImage.translatesAutoresizingMaskIntoConstraints = false
//            editIconImage.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
//            editIconImage.centerYAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 35).isActive = true
            
            //return tableView.tableHeaderView
            
        } else {
         return UIView()
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


  
}
