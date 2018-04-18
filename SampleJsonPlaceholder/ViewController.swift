//
//  ViewController.swift
//  SampleJsonPlaceholder
//
//  Created by Sundir Talari on 08/04/18.
//  Copyright © 2018 Sundir Talari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    var smallArr = [MyModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        table.estimatedRowHeight = 68.0
        table.rowHeight = UITableViewAutomaticDimension
        
        table.delegate = self
        table.dataSource = self
        
        
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        URLSession.shared.dataTask(with: url!) { data, response,error in
            
            guard let data = data else {return}
            
            do {
                
                 let json = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
                //print(json)
                //print("\(((json)[0] as! [String: Any])["title"]!)")
                print("\(((json)[0] as![String: Any])["body"]!)")
                
                for element in json {
                    let userIdFromServer = (element as![String: Any])["userId"] as! Int
                    let idFromServer = (element as![String: Any])["id"] as! Int
                    let titleFromServer = (element as![String: Any])["title"] as! String
                    let bodyFromServer = (element as![String: Any])["body"] as! String
                    
                    let myModelObj = MyModel()
                    myModelObj.userId = userIdFromServer
                    myModelObj.id = idFromServer
                    myModelObj.title = titleFromServer
                    myModelObj.body = bodyFromServer
                    
                    self.smallArr.append(myModelObj)
                    
                    
                }
                
                
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
                
                
            }catch {
                print("json error: \(error.localizedDescription)")
            }
            
        }.resume()
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return smallArr.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        
        let myModelObj = smallArr[indexPath.row]
        cell.titleLabel.text = "Title:\(myModelObj.title)"
        cell.bodyLabel.text = "Body:\(myModelObj.body)"
        return cell
    }
    

}

