//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Muhammad Ziddan Hidayatullah on 12/09/22.
//

import Foundation

protocol CoinManagerDelegate {
    func updateCurrency(_ coinManager: CoinManager, dataModel: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "E5AE1021-7083-4477-A972-6B711E713CC5"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        let url = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        request(with: url)
    }
    
    func request(with url: String) {
        
        guard let urlObject = URL(string: url) else {return}
        let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: urlObject) { data, response, error in
            if error != nil {
                delegate?.didFailWithError(error: error!)
                return
            }
            
            guard let safeData = data else {return}
            
            guard let parsedData = parseJSON(with: safeData) else {return}
            delegate?.updateCurrency(self, dataModel: parsedData)
        }
        
        task.resume()
    }
    
    func parseJSON(with data: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinModel.self, from: data)
            return decodedData
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
