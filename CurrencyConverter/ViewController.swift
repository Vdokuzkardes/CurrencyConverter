//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Vedat Dokuzkardeş on 15.11.2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var cadLbl: UILabel!
    @IBOutlet weak var chfLbl: UILabel!
    @IBOutlet weak var gbpLbl: UILabel!
    @IBOutlet weak var usdLbl: UILabel!
    @IBOutlet weak var tryLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func convertBtn(_ sender: Any) {
        
        // 1) Request & Session
        // 2) Response & Data
        // 3) Parsing & JSON Serialization
        
        
        // 1)
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=75089d549b743fd255d2d355369d42c1")
        let session = URLSession.shared
        
        //Closure
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            }else{
                // 2)
                if data != nil {
                    
                    
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any]{
                               // print(rates)
                                
                                if let cad = rates["CAD"] as? Double{
                                    self.cadLbl.text = "CAD: \(cad)"
                                }
                                if let chf = rates["CHF"] as? Double{
                                    self.chfLbl.text = "CHF: \(chf)"
                                }
                                if let gbp = rates["GBP"] as? Double{
                                    self.gbpLbl.text = "CAD: \(gbp)"
                                }
                                if let usd = rates["USD"] as? Double{
                                    self.usdLbl.text = "USD: \(usd)"
                                }
                                if let tl = rates["TRY"] as? Double{
                                    self.tryLbl.text = "TRY: \(tl)"
                                }
                               
                            }
                        }
                        
                    }catch{
                        print("error")
                    }
                }
                
                
            }
        }
        
        task.resume()
    }
    
}

