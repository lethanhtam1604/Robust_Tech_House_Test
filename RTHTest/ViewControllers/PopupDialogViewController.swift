//
//  PopupDialogViewController.swift
//  RTHTest
//
//  Created by Thanh-Tam Le on 9/5/17.
//  Copyright © 2017 Tam. All rights reserved.
//

import UIKit

class PopupDialogViewController: BaseViewController {

    @IBOutlet weak var infoPopupView: BasePopupView!

    override func viewDidLoad() {
        super.viewDidLoad()

        infoPopupView.closeBtn.addTarget(self, action: #selector(actionTapToCloseButton), for: .touchUpInside)

        view.layer.backgroundColor = UIColor.black.withAlphaComponent(0.5).cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    func actionTapToCloseButton() {
        dismiss(animated: false, completion: nil)
    }
}
