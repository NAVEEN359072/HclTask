//
//  AboutCanadaTableViewCell.swift
//  HclTask
//
//  Created by Anand Sakthivel on 16/07/20.
//  Copyright © 2020 Anand Sakthivel. All rights reserved.
//

import UIKit

class AboutCanadaTableViewCell: UITableViewCell {
    
    let containView = UIView()
    let canadaImgView = UIImageView()
    let titleLbl = UILabel()
    let desciptionLbl = UILabel()
    var imageHeight = CGFloat()
    var titleHeight = CGFloat()
    var descriptionHeight = CGFloat()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(containView)
        containView.layer.cornerRadius = 10
        containView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        containView.anchor(top:topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding:UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 10) )
        
        //canadaImgView
        canadaImgView.contentMode = .scaleAspectFit
        canadaImgView.layer.cornerRadius = 50/2
        canadaImgView.layer.masksToBounds = true
        containView.addSubview(canadaImgView)
        canadaImgView.anchor(top: containView.topAnchor, leading: containView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10), size: CGSize.init(width: 50, height: 50))
        //title
        titleLbl.numberOfLines = 0
        titleLbl.lineBreakMode = .byWordWrapping
        containView.addSubview(titleLbl)
        titleLbl.anchor(top: containView.topAnchor, leading: canadaImgView.trailingAnchor, bottom: nil, trailing: containView.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 10) , size: CGSize.init(width: 0, height: titleHeight))
        //description
        desciptionLbl.numberOfLines = 0
        desciptionLbl.lineBreakMode = .byWordWrapping
        containView.addSubview(desciptionLbl)
        desciptionLbl.anchor(top: canadaImgView.bottomAnchor, leading: containView.leadingAnchor, bottom: containView.bottomAnchor, trailing: containView.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10) , size: CGSize.init(width: 0, height: descriptionHeight))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
