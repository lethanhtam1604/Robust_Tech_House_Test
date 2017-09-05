//
//  BasePopupView.swift
//  RTHTest
//
//  Created by Thanh-Tam Le on 9/5/17.
//  Copyright © 2017 Tam. All rights reserved.
//

import UIKit

class BasePopupView: UIView {

    @IBOutlet var contentView: BasePopupView!
    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var closeBtn: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)

        commoninit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commoninit()
    }

    private func commoninit() {
        //we're going to do stuff here

        Bundle.main.loadNibNamed("BasePopupView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        avatarImgView.layer.cornerRadius = 40

        contentView.layer.cornerRadius = 5
    }
}
