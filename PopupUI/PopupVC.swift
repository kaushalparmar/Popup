//
//  PopupVC.swift
//  Kaushal Parmar
//
//  Created by Kaushal Parmar on 04/06/21.
//

import UIKit

class PopupVC: UIViewController {

    //MARK: - IBOutlet
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!
    
    @IBOutlet weak var vwBG: UIView!
    @IBOutlet weak var vwPopup: UIView!
    
    //MARK: - Variable Declaration
    
    var cancelClicked: (()->())?
    var confirmClicked: (()->())?
    
    var titleText = "Title Here"
    var descriptionText = "Description Here"
    var cancelText = "Cancel"
    var confirmText = "Delete"
    
    var imgData = UIImage(systemName: "trash.fill")!
        
    var isDone = false
    
    var titleFont = UIFont.systemFont(ofSize: 21, weight: .semibold)
    var descriptionFont = UIFont.systemFont(ofSize: 20, weight: .regular)
    var buttonFont = UIFont.systemFont(ofSize: 21, weight: .semibold)
    
    var bgColor = UIColor.black
    var cancelButtonColor = UIColor.black.withAlphaComponent(0.6)
    var confirmButtonColor = UIColor.black

    
    //MARK: - Life Cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !isDone {
            isDone = true
            self.animatePresent()
        }
    }
    
    //MARK: - Private methods
    
    private func initUI() {
        
        self.lblTitle.text = titleText
        self.lblDescription.text = descriptionText
        self.btnCancel.setTitle(cancelText, for: .normal)
        self.btnConfirm.setTitle(confirmText, for: .normal)
        
        self.lblTitle.font = self.titleFont
        self.lblDescription.font = self.descriptionFont
        
        self.btnCancel.titleLabel?.font = buttonFont
        self.btnConfirm.titleLabel?.font = buttonFont
        
        self.btnConfirm.setTitleColor(confirmButtonColor, for: .normal)
        self.btnCancel.setTitleColor(cancelButtonColor, for: .normal)
        
        self.img.image = imgData
        
        self.vwBG.backgroundColor = bgColor
        
        self.vwBG.alpha = 0.0
        self.vwPopup.alpha = 0.0
        
        self.vwPopup.isHidden = true
    }
    
    func animatePresent() {
        self.vwPopup.isHidden = false
        
        let originalTransform = self.vwPopup.transform
        let scaledTransform = originalTransform.scaledBy(x: 0.001, y: 0.001)
        
        self.vwPopup.transform = scaledTransform
        
        let firstScale = originalTransform.scaledBy(x: 1.2, y: 1.2)
        
        self.vwBG.alpha = 0.0
        self.vwPopup.alpha = 0.0
        
        UIView.animate(withDuration: 0.4) {
            self.vwPopup.transform = firstScale
            self.vwBG.alpha = 0.3
            self.vwPopup.alpha = 1.0
        } completion: { flag in
            UIView.animate(withDuration: 0.3) {
                self.vwPopup.transform = originalTransform
            }
        }
    }
    
    func animateDismiss() {
        let originalTransform = self.vwPopup.transform
        let scaledTransform = originalTransform.scaledBy(x: 0.001, y: 0.001)
        let firstScale = originalTransform.scaledBy(x: 1.2, y: 1.2)
        
        UIView.animate(withDuration: 0.3) {
            self.vwPopup.transform = firstScale
        } completion: { flag in
            UIView.animate(withDuration: 0.4) {
                self.vwPopup.transform = scaledTransform
            } completion: { done in
                self.vwBG.alpha = 0.0
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
        
    //MARK: - UIButton IBActions
    
    @IBAction func btnCancelClicked(_ sender: Any) {
        if self.cancelClicked != nil {
            self.cancelClicked!()
        }
        self.animateDismiss()
    }
    
    @IBAction func btnConfirmClicked(_ sender: Any) {
        if self.confirmClicked != nil {
            self.confirmClicked!()
        }
        self.animateDismiss()
    }
}
