//
//  MainViewController.swift
//  RTHTest
//
//  Created by Thanh-Tam Le on 9/1/17.
//  Copyright © 2017 Tam. All rights reserved.
//

import UIKit

//swiftlint:disable line_length
class MainViewController: BaseViewController {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weekdayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!

    var prices: [Price] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        //setup current date
        let currentDate = Utils.getCurrentDate()
        dayLabel.text = Utils.getDayFromDate(date: currentDate)
        weekdayLabel.text = Utils.getWeekdayFromDate(date: currentDate)
        dateLabel.text = Utils.getMonthFromDate(date: currentDate) + " " + Utils.getYearFromDate(date: currentDate)

        //setup tableView
        tableView.delegate = self
        tableView.dataSource = self
        let cellNib = UINib(nibName: PriceTableViewCell.kCellId, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: PriceTableViewCell.kCellId)
        tableView.tableFooterView = UIView()

        containerView.shawdow(Global.colorMain)

        //load data only once
        loadPrices()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if Global.currentWorkFlow == WorkFlow.splashScreen.hashValue {
            let storyboard = UIStoryboard(name: "SplashScreen", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier: "SplashScreenViewController") as? SplashScreenViewController {
                navigationController?.pushViewController(viewController, animated: false)
            }
        }

        Global.currentWorkFlow = WorkFlow.nothing.hashValue
    }

    func loadPrices() {
        APIHelper.getPrices() {
            [weak self] (response, prices) in
            self?.prices = prices ?? [Price]()
            self?.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MainViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prices.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCell(withIdentifier: PriceTableViewCell.kCellId) as! PriceTableViewCell  //swiftlint:disable:this force_cast
        cell.bindingDate(prices[indexPath.row])

        let height = cell.bounds.height + 10
        return height
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PriceTableViewCell.kCellId, for: indexPath) as! PriceTableViewCell //swiftlint:disable:this force_cast
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.bindingDate(prices[indexPath.row])

        return cell
    }
}

extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
}
