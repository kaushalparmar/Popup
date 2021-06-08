# Popup
Two button popup with animated present and dismiss from center of the screen.


# Code to manage Popup

Drag and drop PopupUI folder to your project and set below function in Utils or specific UIViewController, and call this function to open two button popup with animation. then You are done with the popup with two buttons.

    /// Open Popup with two buttons.
    ///
    /// - Parameters:
    ///   - viewController:     UiViewController to present over
    ///   - title:              Title Text for popup
    ///   - descriptionText:    Description Text for Popup
    ///   - confirmText:        Confirm UiButton title
    ///   - cancelText:         Cancel UiButton title
    ///   - imgData:            UIImage for UIImageView
    ///   - titleFont:          UIFont for title text
    ///   - descriptionFont:    UIFont for description text
    ///   - buttonFont:         UIFont for both confirm and cancel button
    ///   - cancelButtonColor:  UIColor for cancel button
    ///   - confirmButtonColor: UIColor for confirm button
    ///   - handler:            handler for the event either confirm or cancel
    
    func openPopup(viewController: UIViewController,
                   title: String = "Title Here",
                   descriptionText: String = "Description Here",
                   confirmText: String = "Yes",
                   cancelText: String = "Cancel",
                   imgData: UIImage = UIImage(systemName: "trash.fill")!,
                   titleFont: UIFont = UIFont.systemFont(ofSize: 21, weight: .semibold),
                   descriptionFont: UIFont = UIFont.systemFont(ofSize: 20, weight: .regular),
                   buttonFont: UIFont = UIFont.systemFont(ofSize: 21, weight: .semibold),
                   cancelButtonColor: UIColor = UIColor.black.withAlphaComponent(0.6),
                   confirmButtonColor: UIColor = UIColor.black,
                   handler: @escaping (Bool) -> Void) {
        
        let deleteVC = PopupVC.init(nibName: "PopupVC", bundle: .main)
        deleteVC.cancelClicked = {
            //cancel clicked
            handler(false)
        }
        deleteVC.confirmClicked = {
            //confirm clicked
            handler(true)
        }
        deleteVC.titleText = title
        deleteVC.descriptionText = descriptionText
        deleteVC.cancelText = cancelText
        deleteVC.confirmText = confirmText
        
        deleteVC.titleFont = titleFont
        deleteVC.descriptionFont = descriptionFont
        deleteVC.buttonFont = buttonFont

        deleteVC.cancelButtonColor = cancelButtonColor
        deleteVC.confirmButtonColor = confirmButtonColor

        deleteVC.imgData = imgData
        
        deleteVC.modalPresentationStyle = .overCurrentContext
        deleteVC.view.backgroundColor = .clear
        self.present(deleteVC, animated: false, completion: nil)
    }
