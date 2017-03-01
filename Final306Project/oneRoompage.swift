//
//  oneRoompage.swift
//  Final306Project
//
//  Created by Paolo Garcia  on 2/1/17.
//  Copyright © 2017 PNGapps. All rights reserved.
//

import UIKit
import SwiftyJSON

class oneRoompage: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var lampSwitch: UISwitch!
    @IBOutlet var tvSwitch: UISwitch!
    @IBOutlet var roomLightSwitch: UISwitch!
    @IBOutlet var ACUnit: UIPickerView!
    
    @IBOutlet var roomName: UILabel!
    
    //DATA TEST
    @IBOutlet var test: UILabel!

    var numberOfRows = 0
    var roomsArray = [[String]]()
    var pickerData = [String]()
    
    @IBAction func defaultRoom(_ sender: Any) {
        
        lampSwitch.setOn(false, animated: true)
        tvSwitch.setOn(false, animated: true)
        roomLightSwitch.setOn(false, animated: true)
        ACUnit.selectRow(21, inComponent: 0, animated: true)
        
        if (lampSwitch.isOn) {
            roomsArray[intPassed][1] = "on"
        } else {
            roomsArray[intPassed][1] = "off"
        }
        if (tvSwitch.isOn) {
            roomsArray[intPassed][2] = "on"
        } else {
            roomsArray[intPassed][2] = "off"
        }
        if (roomLightSwitch.isOn) {
            roomsArray[intPassed][3] = "on"
        } else {
            roomsArray[intPassed][3] = "off"
        }
        
        for i in 0 ..< roomsArray.count {
            roomsArray[intPassed][4] = pickerData[i]
        }
    }
    
    @IBAction func submitDataButton(_ sender: Any) {
        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!
        
        let jsonFilePath = documentsDirectoryPath.appendingPathComponent("THEtest.json")
        let fileManager = FileManager.default
        var isDirectory: ObjCBool = false
        
        // creating a .json file in the Documents folder
        if !fileManager.fileExists(atPath: (jsonFilePath?.absoluteString)!, isDirectory: &isDirectory) {
            let created = fileManager.createFile(atPath: (jsonFilePath?.absoluteString)!, contents: nil, attributes: nil)
            if created {
                print("File created ")
            } else {
                print("Couldn't create file for some reason")
            }
        } else {
            print("File already exists")
        }
        
        if (lampSwitch.isOn) {
            roomsArray[intPassed][1] = "on"
        } else {
            roomsArray[intPassed][1] = "off"
        }
        if (tvSwitch.isOn) {
            roomsArray[intPassed][2] = "on"
        } else {
            roomsArray[intPassed][2] = "off"
        }
        if (roomLightSwitch.isOn) {
            roomsArray[intPassed][3] = "on"
        } else {
            roomsArray[intPassed][3] = "off"
        }
        
        roomsArray[intPassed][4] = pickerData[30]
        
        print(roomsArray)
        
        // creating an array of test data
        var numbers = [String]()
        for i in 0 ..< 100 {
            numbers.append("Test\(i)")
        }
        
        // creating JSON out of the above array
        var jsonData: NSData!
        do {
            jsonData = try JSONSerialization.data(withJSONObject: numbers, options: JSONSerialization.WritingOptions()) as NSData!
            //let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8)
            //NSLog(jsonString!)
        } catch let error as NSError {
            print("Array to JSON conversion failed: \(error.localizedDescription)")
        }
        
        // Write that JSON to the file created earlier
        //let jsonFilePath1 = documentsDirectoryPath.appendingPathComponent("theTest.json")
        do {
            let file = try FileHandle(forWritingTo: jsonFilePath!)
            file.write(jsonData as Data)
            print("JSON data was written to the file successfully!")
        } catch let error as NSError {
            print("Couldn't write to file: \(error.localizedDescription)")
        }
    }
    
    
    //DATA TEST
    var intPassed = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ACUnit.delegate = self
        self.ACUnit.delegate = self
        pickerData = ["45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80"]
        
        //DATA TEST
        NSLog("!!!!!!!!!!!!!!!!!!!!\(intPassed)")
        test.text = " int: \(intPassed)"
        
        parseJSON()
    }
    
    func parseJSON() {
        let path : String = Bundle.main.path(forResource: "dataRoom", ofType: "json") as String!
        let roomData = NSData(contentsOfFile: path) as NSData!
        let readableJSON = JSON(data: roomData as! Data, options: JSONSerialization.ReadingOptions.mutableContainers, error: nil)
        
        numberOfRows = readableJSON["rooms"].count
        
        for row in 1...numberOfRows {
            var Room = "room"
            Room += "\(row)"
            
            let rooms = readableJSON["rooms"][Room]["roomNumber"].string as String!
            let lamps = readableJSON["rooms"][Room]["lamp"].string as String!
            let tvs = readableJSON["rooms"][Room]["tv"].string as String!
            let roomLights = readableJSON["rooms"][Room]["roomLight"].string as String!
            let acUnits = readableJSON["rooms"][Room]["acUnit"].string as String!
            
            roomsArray.append([rooms!, lamps!, tvs!, roomLights!, acUnits!])
            
        }
        NSLog("!!!!!room\(roomsArray)")
        
        roomName.text = roomsArray[intPassed][0]
        if (roomsArray[intPassed][1] == "on") {
            lampSwitch.setOn(true, animated: true)
            print("lamp on")
        } else {
            lampSwitch.setOn(false, animated: true)
            print("lamp off")
        }
        if (roomsArray[intPassed][2] == "on") {
            tvSwitch.setOn(true, animated: true)
            print("tv on")
        } else {
            tvSwitch.setOn(false, animated: true)
            print("tv off")
        }
        if (roomsArray[intPassed][3] == "on") {
            roomLightSwitch.setOn(true, animated: true)
            print("room light on")
        } else {
            roomLightSwitch.setOn(false, animated: true)
            print("room light off")
        }
        ACUnit.selectRow(30, inComponent: 0, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
    
    
    
    
    
    
    
}
