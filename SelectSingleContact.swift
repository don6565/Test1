/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 A BaseViewController subclass that implements the Single Contact tab. Creates
 and presents a contact picker view controller when tapping "Show Picker" in the
 UI. Uses CNContactPickerDelegate's contact​Picker(_ picker: CNContactPickerViewController,
 didSelect contact: CNContact​) to allow users to select and return a single contact.
 */

import UIKit
import ContactsUI

class SelectSingleContact: BaseViewController {
    // MARK: - Display Picker
    
    /**
     Presents a contacts picker view when users tap "Show Picker" in the
     Single Contact tab. Select a contact in the picker to continue.
     */
    @IBAction func showPicker(_ sender: UIButton) {
        hideStackView(true)
        
        let picker = CNContactPickerViewController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let  section = data[indexPath.section].section
        let item = section[indexPath.row]
        cell.textLabel?.text = item.value
    }
}

/**
 Extends `SelectSingleContact` to conform to the `CNContactPickerDelegate`
 protocol.
 */
extension SelectSingleContact: CNContactPickerDelegate {
    /**
     Called when users select a single contact. Calls hideStackView(_:) to
     update the table view with the selection.
     */
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let item = [LabelValue(value: contact.formattedName)]
        data = [Section(section: item)]
        
        // Show and update the table view with the above contact.
        hideStackView(false)
    }
}
