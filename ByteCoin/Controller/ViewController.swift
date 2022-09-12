//
//  ViewController.swift
//  ByteCoin
//
//  Created by Muhammad Ziddan Hidayatullah on 09/09/22.
//

import UIKit

class ViewController: UIViewController, CoinManagerDelegate {
    
    
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    var coinModel: CoinModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
    
    func updateCurrency(_ coinManager: CoinManager, dataModel: CoinModel) {
        coinModel = dataModel
        DispatchQueue.main.async {
            self.updateUI()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func updateUI() {
        currencyLabel.text = coinModel?.currency
        bitcoinLabel.text = String(format: "%.2f", coinModel?.rate ?? 0.0)
        
    }


}

//MARK: - UIPickerView DataSorce and Delegate
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let currency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: currency)
    }
    
    
}
