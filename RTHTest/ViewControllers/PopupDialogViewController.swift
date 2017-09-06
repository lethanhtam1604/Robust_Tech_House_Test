//
//  PopupDialogViewController.swift
//  RTHTest
//
//  Created by Thanh-Tam Le on 9/5/17.
//  Copyright © 2017 Tam. All rights reserved.
//

import UIKit

class PopupDialogViewController: BaseViewController {

    @IBOutlet fileprivate weak var infoPopupView: BasePopupView!

    override func viewDidLoad() {
        super.viewDidLoad()

        infoPopupView.isHidden = true
        infoPopupView.delegate = self

        view.layer.backgroundColor = UIColor.black.withAlphaComponent(0.6).cgColor
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        infoPopupView.isHidden = false
        infoPopupView.increaseSize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PopupDialogViewController: BasePopupViewDelegate {

    func actionTapTocloseButton() {
        dismiss(animated: false, completion: nil)
    }
}
