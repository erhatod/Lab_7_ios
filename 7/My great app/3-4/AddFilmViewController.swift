//
//  AddFilmViewController.swift
//  My great app
//
//  Created by Oleksii Afonin on 30.11.2020.
//

import UIKit

class AddFilmViewController: UIViewController {
    
    weak var parentVC: ViewController?
    
    @IBOutlet weak var filmTitle: UITextField!
    @IBOutlet weak var type: UITextField!
    @IBOutlet weak var year: UITextField!
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyboard()
    }
    
    func hideKeyboard() {
        filmTitle.resignFirstResponder()
        type.resignFirstResponder()
        year.resignFirstResponder()
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        if let title = filmTitle.text, let type = type.text, let year = year.text {
            if (!title.isEmpty && !type.isEmpty && !year.isEmpty) {
                if let yearInt = Int(year) {
                    if 1900 <= yearInt && yearInt < 2021 {
                        let moview = Movie(title: title, type: type, year: String(yearInt))
                        parentVC?.allMovies.append(moview)
                        hideKeyboard()
                        navigationController?.popViewController(animated: true)
                    } else {
                        hideKeyboard()
                        showAlert(message: "Strange year of the film!")
                    }
                } else {
                    hideKeyboard()
                    showAlert(message: "Year is not int!")
                }
            } else {
                hideKeyboard()
                showAlert(message: "Some fields are missing!")
            }
        }
    }
    
    func showAlert(message: String){
        let ac = UIAlertController(title: "Ooops", message: message, preferredStyle: .alert)
        let aa = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        ac.addAction(aa)
        self.present(ac, animated: true, completion: nil)
    }
    
    
}
