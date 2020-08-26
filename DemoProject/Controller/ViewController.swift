//
//  ViewController.swift
//  DemoTab
//
//  Created by CitySpidey on 6/25/20.
//  Copyright © 2020 Shubham Bhadauria. All rights reserved.
//

import UIKit

class Convenience {
    let name:String
    let description:String
    
    init(name:String, description:String){
        self.name = name
        self.description = description
    }
    
    convenience init(description:String) {
        self.init(name: "Shubham", description: description)
    }
}

class ViewController: UIViewController {
    
    let arrofNum:[Int?] = [1,2, nil, 3,4]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let dateString:String? = "12/21/1990"
        print("\(dateString!.calcAge())")
        
        UIAlertController.alert(title: "Hello", message: "Welcome back to Home Page", viewController: self)
        
        /*let arr = ["","",""]
        for i in 0..<arr.count {
            
        }*/
        
        //Test()
        //Map()
    }
    
    func Test(){
        for num in arrofNum{
            if let num = num {
                print("\(num)")
            }
            else {
                print("Empty Value")
                //break
            }
            //print(num)
        }
        
        let con = Convenience(description: "Description")
        print(con.name)
        print(con.description)
        
        
        var name = "Bhadauria"
        var surname = "Shubham"
        swapTwoNumber(&surname, &name)
        print("someInt is now \(name), and anotherInt is now \(surname)")
    }
    
    func swapTwoNumber<T>(_ v1: inout T, _ v2: inout T){
        let temp = v1
        v1 = v2
        v2 = temp
    }
    
    func Map(){
        
        // Mapping
        let arr:[Int] = [1,2,3,4,5,6,7,8,9,10]
        var arr1:[Int] = []
        for num in arr{
            arr1.append(num*2)
        }
        
        let arrMap1 = arr.map { (num) in
            return num*2
        }
        print("\(arrMap1)")
        
        let arrMap2 = arr.map {$0 * 2}
        print("\(arrMap2)")
        
        
        //Filter
        let arrFilter = arr.filter {$0 % 2 == 0}
        print("\(arrFilter)")
        
        //Reduce
        let arrReduce = arr.reduce (0,{$0 + $1})
        print("\(arrReduce)")

        let arrReduce1 = arr.reduce (0,+)
        print("\(arrReduce1)")
        
        let arrSorting = arr.sorted{$0 > $1}
        print("\(arrSorting)")
        
        let arrofFlat = [[11,12,13],[14,15,16]]
        let flatMap = arrofFlat.flatMap{$0}.filter{$0 % 2 == 0}.map{$0 * $0}
        let reduce = flatMap.reduce(0, {$0 + $1})
        print("\(flatMap)")
        print("\(reduce)")
    }
    
    /*func setUpGeoIQ(){
        let headers:HTTPHeaders = [
        .contentType("application/json")
        ]
            let param:[String:String] = [
                "key":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJtYWlsSWRlbnRpdHkiOiJpdEBzdGV2ZW1lZGl1cy5jb20ifQ.yHRKdeVTbkTaP4Um8SfnVr4xOZYfQbhuOd7Pvl6EIDg",
                //"pincode":"110001"
            ]
        
        AF.request("https://data.geoiq.io/dataapis/v1.0/covid/availablecities", method: .post, parameters: param, encoder: JSONParameterEncoder.default, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSON(data:data!)
                    print(json)
                    
                    let dict = json["data"]
                    let isContainmentZone = dict["hasContainmentZone"]
                    //print(dict1 as Any)
                    
                    if response.response?.statusCode == 200 {
                        //completionHandler(.success(json))
                    }
                    else{
                        //completionHandler(.failure(.custom(message: "Please Check your Network Connection")))
                    }
                }catch{
                   // completionHandler(.failure(.custom(message: "Please Try Again")))
                }
            case .failure(let error):
                print(error.localizedDescription)
                //completionHandler(.failure(.custom(message: "Please Try Again")))
            }
        }
    }*/
}
