//
//  ViewController.swift
//  Final306Project
//
// Created Alex Hansen
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet var employeeID: UITextField!
    @IBOutlet var employeePassword: UITextField!

    var numberOfRows = 0
    var employeeArray = [String]()
    var passwordArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //parseJSON()

    }
    func parseJSON() {
        let path : String = Bundle.main.path(forResource: "loginUser", ofType: "json") as String!
        let loginData = NSData(contentsOfFile: path) as NSData!
        let readableJSON = JSON(data: loginData as! Data, options: JSONSerialization.ReadingOptions.mutableContainers, error: nil)
        
        numberOfRows = readableJSON[0].count
        print("Counter\(numberOfRows)")
        
        for i in 1...numberOfRows {
            var login = "login"
            login += "\(i)"
            
            let loginID = readableJSON[0][login]["username"].string as String!
            let passwordID = readableJSON[0][login]["password"].string as String!
            
            employeeArray.append(loginID!)
            passwordArray.append(passwordID!)
        }
    }

    func downloadItems() {
        let url =  "http://192.168.99.34/SMARTRoom.php"
        let myUrl = NSURL(string: url)
        var request = URLRequest(url:myUrl! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest) {data,response,error in
            let httpResponse = response as? HTTPURLResponse
            
            if (error != nil) {
                print(error )
            } else {
                print(httpResponse)
            }
            
            DispatchQueue.main.async {
                //Update your UI here
            }
            
        }
        dataTask.resume()
    }
    @IBAction func loginButton(_ sender: Any) {
        let username = self.employeeID.text
        let password = self.employeePassword.text
        downloadItems()
        parseJSON()
     
        
        
        NSLog("\(employeeArray)")
        NSLog("\(passwordArray)")
        NSLog("\(numberOfRows)")
        NSLog("\(username)")
        NSLog("\(password)")
        if ((username?.isEmpty)! || (password?.isEmpty)!) {
            let alertController = UIAlertController(title: "INVALID", message: "All fields are required", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
                action in
            }
            alertController.addAction(cancelAction)
            let okAction = UIAlertAction(title: "OK", style: .default) {
                action in
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true) {
            }
            return
        }
        
        var b = 0
        while (b < numberOfRows) {
           
            if (username == employeeArray[b] && password == passwordArray[b]) {
                NSLog("LOGGED IN")
                return
            } else {
                 b += 1
            }
        }
        let alertController = UIAlertController(title: "INVALID", message: "Username and password do not match", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
            action in
        }
        alertController.addAction(cancelAction)
        let okAction = UIAlertAction(title: "OK", style: .default) {
            action in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true) {
        }

        
        }
        
    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}





