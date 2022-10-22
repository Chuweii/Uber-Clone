//
//  SearchViewController.swift
//  Uber Clone
//
//  Created by Wei Chu on 2022/10/19.
//

import UIKit
import CoreLocation

protocol SearchViewControllerDelegate:AnyObject{
    func searchViewController(vc:SearchViewController, didSelectLocationWith coordinates:CLLocationCoordinate2D?)
}

class SearchViewController: UIViewController {
    
    weak var delegate:SearchViewControllerDelegate?
    
    private let label:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = "Where did you go?"
        label.numberOfLines = 0
        return label
    }()
    
    private let textField:UITextField = {
       
        let textfield = UITextField()
        textfield.placeholder = "Enter destination"
        textfield.backgroundColor = .tertiarySystemBackground
        textfield.layer.cornerRadius = 8
        textfield.leftViewMode = .always
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        
        return textfield
    }()
    
    private let tableView:UITableView = {
       
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
        
    }()
    
    var locations = [Location]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(label)
        view.addSubview(textField)
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        textField.delegate = self
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        label.frame = CGRect(x: 10, y: 10, width: label.frame.size.width, height: label.frame.size.height)
        textField.frame = CGRect(x: 10, y: 20+label.frame.size.height, width: view.frame.size.width-20 , height: 50)
        let tableY:CGFloat = textField.frame.origin.y+textField.frame.size.height+5
        tableView.frame = CGRect(x: 0, y: tableY, width: view.frame.size.width, height: view.frame.size.height - tableY)
    }
    
}

extension SearchViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text, !text.isEmpty{
            LocationManager.shared.findLocation(with: text) { [weak self] locations in
                DispatchQueue.main.async {
                    self?.locations = locations
                    self?.tableView.reloadData()
                }
            }
        }
        
        return true
    }
}


extension SearchViewController:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = locations[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        cell.contentView.backgroundColor = .secondarySystemBackground
        cell.backgroundColor = .secondarySystemBackground
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //notify map controller to show pin at selected place
        let coordinate = locations[indexPath.row].coordinates
        
        delegate?.searchViewController(vc: self, didSelectLocationWith: coordinate)
        
    }
}
