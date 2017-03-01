//
//  Roompage.swift
//  Final306Project
//
//  Created by Paolo Garcia  on 1/19/17.
//  Copyright © 2017 PNGapps. All rights reserved.
//

import UIKit
import SwiftyJSON

class RoomPage: UITableViewController {
    
    var numberOfRows = 0
    var roomsArray = [String]()
    
    
    //DATA TEST
    var roomInt = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //DATA TEST
        roomInt = 1
        
        parseJSON()
        
        //DATA TEST
        let myVC = storyboard?.instantiateViewController(withIdentifier: "oneRoompage") as! oneRoompage
        myVC.intPassed = roomInt
        NSLog("YO \(myVC.intPassed)")
        navigationController?.pushViewController(myVC, animated: true)
    }
    
    func parseJSON() {
        let path : String = Bundle.main.path(forResource: "dataRoom", ofType: "json") as String!
        let roomData = NSData(contentsOfFile: path) as NSData!
        let readableJSON = JSON(data: roomData as! Data, options: JSONSerialization.ReadingOptions.mutableContainers, error: nil)
        
        numberOfRows = readableJSON["rooms"].count
        
        for i in 1...numberOfRows {
            var Room = "room"
            Room += "\(i)"
            let rooms = readableJSON["rooms"][Room]["roomNumber"].string as String!
            
            roomsArray.append(rooms!)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        
        cell.textLabel?.text = roomsArray[indexPath.row]
        
        return cell
    }
}
