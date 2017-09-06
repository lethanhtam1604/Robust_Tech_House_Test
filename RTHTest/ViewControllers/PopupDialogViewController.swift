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

        infoPopupView.isHidden = true

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

    func actionTapToCloseButton() {
        dismiss(animated: false, completion: nil)
    }
}
