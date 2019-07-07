//
//  SearchNewsController.swift
//  NewsApp
//
//  Created by Aragones, Sergio (ES - Madrid) on 06/07/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class SearchNewsController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var typesButton: PickOptionButton!
    @IBOutlet weak var periodsButton: PickOptionButton!
    @IBOutlet weak var shareTypesButton: PickOptionButton!
    
    @IBOutlet fileprivate var pickerView: UIPickerView!
    
    @IBOutlet fileprivate var hidePickerViewConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate var shareTypesButtonHeight: NSLayoutConstraint!
    
    let types = ["mostemailed",
                 "mostshared",
                 "mostviewed"
                ]
    var selectedType = 0
    let periods = ["1",
                   "7",
                   "30"
                  ]
    var selectedPeriod = 0
    let shareTypes = ["email",
                   "facebook",
                   "twitter"
    ]
    var selectedShareType = 0
    
    enum PickerViewMode: Int {
        case type = 0
        case period = 1
        case shareType = 2
    }
    
    fileprivate var pickerViewMode: PickerViewMode = .type {
        didSet {
            pickerView.reloadAllComponents()
            
            var rowToSelect: Int = 0
            switch pickerViewMode {
            case .type:
                rowToSelect = selectedType
            case .period:
                rowToSelect = selectedPeriod
            case .shareType:
                rowToSelect = selectedShareType
            }
            pickerView.selectRow(rowToSelect, inComponent: 0, animated: false)
        }
    }
    
    
    init(){
        super.init(nibName: "SearchNewsView", bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleLabel.text = "Búsqueda"
        
        mainLabel.attributedText = NSAttributedString(string: mainLabel.text!, attributes: [.font: UIFont.robotoRegular18, .foregroundColor: UIColor.negro])
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    
    @IBAction func showTypePickerView() {
        pickerViewMode = .type
        hidePickerViewConstraint.isActive = false
        
        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0,
            options: [.beginFromCurrentState],
            animations: { () -> Void in
                self.view.layoutIfNeeded()
        },
            completion: nil
        )
    }
    @IBAction func showPeriodPickerView() {
        pickerViewMode = .period
        hidePickerViewConstraint.isActive = false
        
        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0,
            options: [.beginFromCurrentState],
            animations: { () -> Void in
                self.view.layoutIfNeeded()
        },
            completion: nil
        )
    }
    @IBAction func showShareTypePickerView() {
        pickerViewMode = .shareType
        hidePickerViewConstraint.isActive = false
        
        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0,
            options: [.beginFromCurrentState],
            animations: { () -> Void in
                self.view.layoutIfNeeded()
        },
            completion: nil
        )
    }
    @IBAction func hidePickerView() {
        hidePickerViewConstraint.isActive = true
        
        switch pickerViewMode {
        case .type:
            typesButton.title = types[selectedType-1]
            shareTypesButtonHeight.constant = selectedType == 2 ? 30 : 0
        case .period:
            periodsButton.title = periods[selectedPeriod-1]
        case .shareType:
            shareTypesButton.title = shareTypes[selectedShareType-1]
        }
        
        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0,
            options: [.beginFromCurrentState],
            animations: { () -> Void in
                self.view.layoutIfNeeded()
        },
            completion: nil
        )
    }
    @IBAction func commitPickerView() {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        if selectedRow != 0 {
            switch pickerViewMode {
            case .type:
                selectedType = selectedRow
            case .period:
                selectedPeriod = selectedRow
            case .shareType:
                selectedShareType = selectedRow
            }
            hidePickerView()
        }
    }
    
    @IBAction func searchNews(_ sender: Any) {
        guard selectedType > 0 else {
            typesButton.showError("Debes seleccionar un tipo")
            return
        }
        guard selectedPeriod > 0 else {
            periodsButton.showError("Debes selecionar un periodo")
            return
        }
        let type = types[selectedType-1]
        let period = periods[selectedPeriod-1]
        if selectedType == 2 {
            guard selectedShareType > 0 else {
                shareTypesButton.showError("Debes seleccionar una fuente")
                return
            }
            let shareType = shareTypes[selectedShareType-1]
            navigationController?.pushViewController(ArticlesController(), animated: true)
        }
        else {
            navigationController?.pushViewController(ArticlesController(), animated: true)
        }
    }
    
}
extension SearchNewsController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerViewMode {
        case .type:
            return row==0 ? "Selecciona tipo" : types[row - 1]
        case .period:
            return row==0 ? "Selecciona periodo" : periods[row - 1]
        case .shareType:
            return row==0 ? "Selecciona fuente" : shareTypes[row - 1]
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerViewMode {
        case .type:
            return types.count+1
        case .period:
            return periods.count+1
        case .shareType:
            return shareTypes.count+1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        
        label.textColor = .negro
        label.textAlignment = .center
        label.font = UIFont.robotoMedium14
        
        switch pickerViewMode {
        case .type:
            label.text = row==0 ? "Selecciona tipo" : types[row - 1]
        case .period:
            label.text = row==0 ? "Selecciona periodo" : periods[row - 1]
        case .shareType:
            label.text = row==0 ? "Selecciona fuente" : shareTypes[row - 1]
        }
        
        return label
    }
    
}
