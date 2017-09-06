//
//  BasePopupView.swift
//  RTHTest
//
//  Created by Thanh-Tam Le on 9/5/17.
//  Copyright © 2017 Tam. All rights reserved.
//

import UIKit

protocol BasePopupViewDelegate: class {
    func actionTapTocloseButton()
}

class BasePopupView: UIView {

    @IBOutlet fileprivate var contentView: BasePopupView!
    @IBOutlet fileprivate weak var avatarImgView: UIImageView!
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var emailLabel: UILabel!
    @IBOutlet fileprivate weak var closeBtn: UIButton!

    weak var delegate: BasePopupViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        commoninit()
    }

    private func commoninit() {
        Bundle.main.loadNibNamed("BasePopupView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        avatarImgView.layer.cornerRadius = 40
        contentView.layer.cornerRadius = 5

        closeBtn.addTarget(self, action: #selector(actionTapTocloseButton), for: .touchUpInside)
    }

    func actionTapTocloseButton() {
        delegate?.actionTapTocloseButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commoninit()
    }
}
