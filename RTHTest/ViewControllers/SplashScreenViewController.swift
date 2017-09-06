//
//  SplashScreenViewController.swift
//  RTHTest
//
//  Created by Thanh-Tam Le on 9/1/17.
//  Copyright © 2017 Tam. All rights reserved.
//

import UIKit

class SplashScreenViewController: BaseViewController {

    @IBOutlet fileprivate weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = true

        titleLabel.font = UIFont(name: "MyriadPro-Regular", size: 35)
        titleLabel.textColor = Global.colorMain
        titleLabel.increaseSize()

        Global.currentWorkFlow = WorkFlow.mainScreen.hashValue
        navigateToMainPage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func navigateToMainPage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.popViewController(animated: false)
        }
    }
}
