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
    let refreshControl = UIRefreshControl()
    let cellId = "Cell"
    var canadaVM : CanadaViewModel!
    
    //MARK: - ViewDid load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        canadaVM = CanadaViewModel(self)
        self.title = UserDefaults.standard.navigationTitle
        self.view.backgroundColor = .white
        
        //api call based on condition
        if isAcceptableTimeforSymptomTrackerAPI {
            apiCall()
        }
        canadaVM.canadaDetails = DatabaseController.getAllDetails()
        
        //detailTblView
        detailTblView.delegate = self
        detailTblView.dataSource = self
        detailTblView.separatorStyle = .none
        detailTblView.register(AboutCanadaTableViewCell.self, forCellReuseIdentifier: cellId)
        self.view.addSubview(detailTblView)
        detailTblView.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor)
        
        //add refreshControll
        if #available(iOS 10.0, *) {
            detailTblView.refreshControl = refreshControl
        } else {
            detailTblView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(apiCall), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Canada Data ...")
    }
    
    @objc func apiCall()  {
        if UserDefaults.standard.isNetworkAvailable {
            canadaVM.callCanadaDetails()
        }else {
            /**
             Simple Alert
             - Show alert with title and alert message and Cancel actions
             */
            self.refreshControl.endRefreshing()
            let alert = UIAlertController(title:"Canada Details", message: "Kindly Check Your Internet Connection",         preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { _ in
                //Okay Action
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    func getSuccessData()  {
        canadaVM.canadaDetails = DatabaseController.getAllDetails()
        DispatchQueue.main.async(execute: {
            self.refreshControl.endRefreshing()
            self.detailTblView.reloadData()
        })
    }
}

//MARK: - UITableview datasource and delegate

extension ViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return canadaVM.canadaDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! AboutCanadaTableViewCell
        cell.canadaImgView.loadImageviewUsingUrlString(urlString: canadaVM.getCanadaImage(for: indexPath) ?? "")
        cell.titleLbl.text = canadaVM.getCanadaTitle(for: indexPath)
        cell.desciptionLbl.text = canadaVM.getCanadaDescription(for: indexPath)
        cell.imageHeight = canadaVM.getCanadaImage(for: indexPath) == "" ? 0 : 150
        cell.titleHeight = cell.titleLbl.text == "" ?  0 : rectForText(cell.titleLbl.text ?? "", font: cell.titleLbl.font, maxSize:CGSize(width: 256, height: 2000)).height
        cell.descriptionHeight = cell.desciptionLbl.text == "" ? 0 :  rectForText(cell.desciptionLbl.text ?? "", font: cell.desciptionLbl.font, maxSize:CGSize(width: 256, height: 2000)).height
        cell.selectionStyle = .none
        return cell
    }
    
    
}
