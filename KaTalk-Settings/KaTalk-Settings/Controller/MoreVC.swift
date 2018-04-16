//
//  MoreVC.swift
//  KaTalk-Settings
//
//  Created by Peichun Tsai on 2018/3/19.
//  Copyright © 2018年 Peichun Tsai. All rights reserved.
//

import UIKit

class MoreVC: UITableViewController, UISearchBarDelegate {
    
   
    let imageInCollec = ["1", "2", "3","1-1", "2-1", "3-1", "1-2", "2-2", "3-2"]
    let secondImageInCollec = ["4", "5", "6"]

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let searchBar = UISearchBar()
     
        navigationItem.titleView = searchBar
    navigationItem.hidesSearchBarWhenScrolling = true
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        
       // navigationController?.hidesBottomBarWhenPushed = true
        tableView.backgroundColor = UIColor.groupTableViewBackground
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "More"
        nameLabel.text = UserDefaults.standard.string(forKey: "saveName")
        
        
    }

    
}

extension MoreVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 3
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        switch collectionView.tag {
        case 0:
            return imageInCollec.count
        case 1:
            return secondImageInCollec.count
        default:
            return 1
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.tag {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondCollectionCell", for: indexPath) as! SecondCollectionViewCell
            cell.secondImageView.image = UIImage(named: secondImageInCollec[indexPath.row])
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
            
            cell.imageView.image = UIImage(named: imageInCollec[indexPath.row])
            return cell
        }
    }
}
