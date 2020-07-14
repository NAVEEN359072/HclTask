//
//  ViewController.swift
//  HclTask
//
//  Created by Anand Sakthivel on 14/07/20.
//  Copyright © 2020 Anand Sakthivel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let detailTblView = UITableView()

    //MARK: - ViewDid load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Title"
        self.view.backgroundColor = .white
        
        //detailTblView
        detailTblView.backgroundColor = .red
        detailTblView.delegate = self
        detailTblView.dataSource = self
        self.view.addSubview(detailTblView)
        detailTblView.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor)
        
    }
    
    //MARK: - viewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

//MARK: - UITableview datasource and delegate

extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "test"
        return cell
    }
    
    
}
