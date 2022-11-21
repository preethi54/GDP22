//
//  ViewController.swift
//  SmartParking_GDP
//
//  Created by Jadhav,Preethi Eshwarlal on 11/5/22.
//

import UIKit
//import Firebase


class ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    //var ref: DatabaseReference!
    
    
    let categoryData = ["Student","Faculty","Reserved"];
    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var CategoryLabel: UILabel!
    
    @IBOutlet weak var VehicleLabel: UILabel!
    
    @IBOutlet weak var NameText: UITextField!
    
    @IBOutlet weak var VehicleText: UITextField!
    
    @IBOutlet weak var CategoryText: UIPickerView!
    
    @IBOutlet weak var GoLabel: UIButton!
    
    @IBOutlet weak var ResetLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
       // ref = Database.database().reference()
        
        CategoryText.delegate = self;
        CategoryText.dataSource = self;
        
        if((NameText.text == nil) && (VehicleText.text == nil)){
            GoLabel.isEnabled = false;
            ResetLabel.isEnabled = false;
        }
        
        // Do any additional setup after loading the view.
       // self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Bground.png"))
    //    self.view; setBackgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Bground.png"]];
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Bground.png") ?? nil)

    }
    
    @objc(numberOfComponentsInPickerView:) func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @objc func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryData.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let selectedCategory  = categoryData[row] as String
        return categoryData[row]
    }
    

    @IBAction func ResetButton(_ sender: Any) {
        NameText.text = "";
        VehicleText.text = "";
    }
    
}

