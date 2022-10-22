//
//  SignHeaderView.swift
//  Uber Clone
//
//  Created by Wei Chu on 2022/10/19.
//

import Foundation
import UIKit

class SignHeaderView: UIView {

    private let image:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.image = UIImage(named: "uberlogo2")
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 10
        
        
        return image
    }()
    
    private let label:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "Explore millions of location!"
        
        
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        
        addSubview(image)
        addSubview(label)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
            configureConstraints()
    }
    
    private func configureConstraints(){
        
        let imageConstraints = [
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            image.widthAnchor.constraint(equalToConstant: frame.width / 4 ),
            image.heightAnchor.constraint(equalToConstant: frame.width / 4)
        
        ]
        
        let labelConstraints = [
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            label.heightAnchor.constraint(equalToConstant: 30)
            
        ]
        
        
        NSLayoutConstraint.activate(imageConstraints)
        NSLayoutConstraint.activate(labelConstraints)


    }
    
}
