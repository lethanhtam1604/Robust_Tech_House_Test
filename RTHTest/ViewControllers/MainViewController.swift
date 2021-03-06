//
//  MainViewController.swift
//  RTHTest
//
//  Created by Thanh-Tam Le on 9/1/17.
//  Copyright © 2017 Tam. All rights reserved.
//

import TSMessages
import UIKit

class MainViewController: BaseViewController {

    @IBOutlet fileprivate weak var dayLabel: UILabel!
    @IBOutlet fileprivate weak var weekdayLabel: UILabel!
    @IBOutlet fileprivate weak var dateLabel: UILabel!
    @IBOutlet fileprivate weak var chartView: BezierView!
    @IBOutlet fileprivate weak var containerView: UIView!
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var indicator: UIActivityIndicatorView!

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = Global.colorMain

        return refreshControl
    }()

    var prices: [Price] = []

    var graphPoints: [CGPoint] {
        let k = Int(chartView.frame.width) / (prices.count - 1)
        var result = [CGPoint]()
        var max = 0.0
        for price in prices {
            if Double(price.amount ?? "0") ?? 0 > max {
                max = Double(price.amount ?? "0") ?? 0
            }
        }
        let delta = Double(chartView.frame.height) / max
        for i in 0..<prices.count {

            result.append(CGPoint(x: Double(i * k), y: Double(chartView.frame.height) - (Double(prices[i].amount ?? "0") ?? 0) * delta))
        }

        return result
    }

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
        tableView.addSubview(refreshControl)

        containerView.shawdow(Global.colorMain)
    }

    func handleRefresh(_ refreshControl: UIRefreshControl) {
        loadPrices()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        switch Global.currentWorkFlow {
        case WorkFlow.splashScreen.hashValue:
            let storyboard = UIStoryboard(name: "SplashScreen", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier: "SplashScreenViewController") as? SplashScreenViewController {
                navigationController?.pushViewController(viewController, animated: false)
            }
        case WorkFlow.mainScreen.hashValue:
            indicator.startAnimating()
            loadPrices()
        default:
            break
        }

        Global.currentWorkFlow = WorkFlow.nothing.hashValue
    }

    func loadPrices() {
        if Utils.isInternetAvailable() {
            APIHelper.getPrices { [unowned self] (_, prices) in
                self.prices.removeAll()
                self.prices.append(contentsOf: prices ?? [Price]())

                for i in 0..<self.prices.count {
                    DatabaseHelper.getInstance().savePrice(self.prices[i])
                }

                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.indicator.stopAnimating()
                self.chartView.drawChart(self.graphPoints)
            }
        } else {
            self.prices = DatabaseHelper.getInstance().getPrices() ?? [Price]()
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            self.indicator.stopAnimating()
            self.chartView.drawChart(self.graphPoints)

            TSMessage.showNotification(withTitle: "Network error", subtitle: "Couldn't connect to the server. Check your network connection.", type: .error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func actionTapToInfoButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "PopupDialogViewController") as? PopupDialogViewController {
            viewController.modalPresentationStyle = .overCurrentContext
            present(viewController, animated: false, completion: nil)
        }
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
        chartView.fadeColorAtPoint(indexPath.row)
    }
}
