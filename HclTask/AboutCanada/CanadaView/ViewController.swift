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
    let canadaVM = CanadaViewModel()
    
    //MARK: - ViewDid load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = UserDefaults.standard.navigationTitle
        self.view.backgroundColor = .white
        if(isAcceptableTimeforSymptomTrackerAPI) {
            apiCall()
        }
        canadaVM.canadaDetails = DatabaseController.getAllDetails()
        //detailTblView
        detailTblView.delegate = self
        detailTblView.dataSource = self
        detailTblView.separatorStyle = .none
        detailTblView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
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
        //http://fyimusic.ca/wp-content/uploads/2008/06/hockey-night-in-canada.thumbnail.jpg  404
        //"http://files.turbosquid.com/Preview/Content_2009_07_14__10_25_15/trebucheta.jpgdf3f3bf4-935d-40ff-84b2-6ce718a327a9Larger.jpg"   403
        //"http://caroldeckerwildlifeartstudio.net/wp-content/uploads/2011/04/IMG_2418%20majestic%20moose%201%20copy%20(Small)-96x96.jpg"
 404
        

    }
    
    //MARK: - viewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @objc func apiCall()  {
        if UserDefaults.standard.isNetworkAvailable {
            canadaVM.callCanadaDetails()
             self.refreshControl.endRefreshing()
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
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) else {
            return UITableViewCell()
        }
        for cell in cell.subviews {
            cell.removeFromSuperview()
        }
        
        let containView = UIView()
        cell.addSubview(containView)
        containView.layer.cornerRadius = 10
        containView.layer.borderWidth = 1.0
        containView.layer.borderColor = UIColor.lightGray.cgColor
        containView.anchor(top: cell.topAnchor, leading: cell.leadingAnchor, bottom: cell.bottomAnchor, trailing: cell.trailingAnchor,padding:UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20) )
        
        //canadaImgView
        let canadaImgView = UIImageView()
        canadaImgView.loadImageviewUsingUrlString(urlString:canadaVM.getCanadaImage(for: indexPath) ?? "" )
        canadaImgView.contentMode = .scaleAspectFit
        //canadaImgView.image = UIImage.init(named: "Test")
        containView.addSubview(canadaImgView)
        canadaImgView.anchor(top: containView.topAnchor, leading: containView.leadingAnchor, bottom: nil, trailing: containView.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10), size: CGSize.init(width: 0, height: canadaVM.getCanadaImage(for: indexPath) == "" ? 0 : 150))
        //title
        let titleLbl = UILabel()
        titleLbl.text = canadaVM.getCanadaTitle(for: indexPath)
        titleLbl.numberOfLines = 0
        titleLbl.lineBreakMode = .byWordWrapping
        containView.addSubview(titleLbl)
        titleLbl.anchor(top: canadaImgView.bottomAnchor, leading: containView.leadingAnchor, bottom: nil, trailing: containView.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 10, bottom: 0, right: 10) , size: CGSize.init(width: 0, height: canadaVM.getCanadaImage(for: indexPath) == "" ? 0 : titleLbl.text == "" ?  0 : rectForText(titleLbl.text ?? "", font: titleLbl.font, maxSize:CGSize(width: 256, height: 2000)).height))
        //description
        let desciptionLbl = UILabel()
        desciptionLbl.text = canadaVM.getCanadaDescription(for: indexPath)
        desciptionLbl.numberOfLines = 0
        desciptionLbl.lineBreakMode = .byWordWrapping
        containView.addSubview(desciptionLbl)
        desciptionLbl.anchor(top: titleLbl.bottomAnchor, leading: containView.leadingAnchor, bottom: containView.bottomAnchor, trailing: containView.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10) , size: CGSize.init(width: 0, height: desciptionLbl.text == "" ? 0 :  rectForText(desciptionLbl.text ?? "", font: desciptionLbl.font, maxSize:CGSize(width: 256, height: 2000)).height))
        cell.selectionStyle = .none
        return cell
    }
    
    
}
