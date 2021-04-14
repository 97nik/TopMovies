//
//  alert.swift
//  TopMovies
//
//  Created by Никита on 13.04.2021.
//

import Foundation
import UIKit

extension TableViewController   {
    func presentSearchAlertController() {
        
    let alertController = UIAlertController(title: "Ошибка", message: "Что-то пошло не так(", preferredStyle: .alert)
            
    let action1 = UIAlertAction(title: "Ок", style: .default) { (action:UIAlertAction) in
        print("You've pressed default");
    }
        alertController.addAction(action1)
        present(alertController, animated: true, completion: nil)
    }
}

extension CollectionViewController  {
    func presentSearchAlertController() {
        
    let alertController = UIAlertController(title: "Ошибка", message: "Что-то пошло не так(", preferredStyle: .alert)
            
    let action1 = UIAlertAction(title: "Ок", style: .default) { (action:UIAlertAction) in
        print("You've pressed default");
    }
        alertController.addAction(action1)
        present(alertController, animated: true, completion: nil)
    }
}
