//
//  ViewController.swift
//  apiTest
//
//  Created by İlkay Türe on 29.09.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var feelsLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    
   
   
 
    override func viewDidLoad() {
        super.viewDidLoad()
        title = " weather api"
    }


    @IBAction func getButtonClicked(_ sender: Any) {
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=37.92155619800274&lon=32.4975113214583&appid=6ed486f2360d825daf03a90f357fa198")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            
            if error != nil {
                print("error")
            }
            else {
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any]
                        
                        DispatchQueue.main.async {
                            if let main = jsonResponse!["main"] as? [String : Any] {
                                  if let temp = main["temp"] as? Double {
                                self.currentTempLabel.text = String(Int(temp-272.15))
                                  }
                            }
                            
                            if let wind = jsonResponse!["wind"] as? [String: Any] {
                                if let speed = wind["speed"] as? Double{
                                    self.windSpeedLabel.text = String(Int(speed))
                                }
                            }
                        }
                    } catch {
                        
                    }
                    
                }
            }
            
        }
        task.resume()
    }
}

