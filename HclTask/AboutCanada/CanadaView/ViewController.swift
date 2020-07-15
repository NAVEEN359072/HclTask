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
    let canadaVM = CanadaViewModel()
    
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
        if UserDefaults.standard.isNetworkAvailable {
            //canadaVM.callCanadaDetails()
        }else {
            /**
             Simple Alert
             - Show alert with title and alert message and Cancel actions
             */
            let alert = UIAlertController(title:"Canada Details", message: "Kindly Check Your Internet Connection",         preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { _ in
                //Okay Action
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
}

//MARK: - UITableview datasource and delegate

extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return canadaVM.canadaDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = canadaVM.getCanadaTitle(for: indexPath)
        return cell
    }
    
    
}
