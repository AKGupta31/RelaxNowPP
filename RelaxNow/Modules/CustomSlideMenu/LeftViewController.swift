//
//  LeftViewController.swift
//  LGSideMenuControllerDemo
//

import Foundation
import UIKit
import LGSideMenuController
class LeftViewController: UIViewController {

    @IBOutlet weak var loggedInUserImage: ZWView!
    
    @IBOutlet weak var lblPhone: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblRole: UILabel!
    
    private var type: DemoType?
    
    
    
    private let titlesArray = [ ["Dashboard",
                               "Patients",
                               "Appointments"],["Profile","Logout"]]

    func setup(type: DemoType) {
        self.type = type
    }

    override var prefersStatusBarHidden: Bool {
        if self.type == .statusBarIsAlwaysVisible {
            return UIApplication.shared.statusBarOrientation.isLandscape && UIDevice.current.userInterfaceIdiom == .phone
        }

        return true
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    

    // MARK: - Logging

    deinit {
        struct Counter { static var count = 0 }
        Counter.count += 1
        print("LeftViewController.deinit(), counter: \(Counter.count)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        struct Counter { static var count = 0 }
        Counter.count += 1
        print("LeftViewController.viewDidLoad(), counter: \(Counter.count)")
        let currentUser = UserData.current
        lblName.text = (currentUser.firstName ?? "") + " " + (currentUser.lastName ??
        "")
        lblRole.text = currentUser.role
        lblPhone.text = currentUser.mobile
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        struct Counter { static var count = 0 }
        Counter.count += 1
        print("LeftViewController.viewWillAppear(\(animated)), counter: \(Counter.count)")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        struct Counter { static var count = 0 }
        Counter.count += 1
        print("LeftViewController.viewDidAppear(\(animated)), counter: \(Counter.count)")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        struct Counter { static var count = 0 }
        Counter.count += 1
        print("LeftViewController.viewWillDisappear(\(animated)), counter: \(Counter.count)")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        struct Counter { static var count = 0 }
        Counter.count += 1
        print("LeftViewController.viewDidDisappear(\(animated)), counter: \(Counter.count)")
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        struct Counter { static var count = 0 }
        Counter.count += 1
        print("LeftViewController.viewWillLayoutSubviews(), counter: \(Counter.count)")
    }
    
}

extension LeftViewController: UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titlesArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return titlesArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeftViewCell

        cell.titleLabel.text = titlesArray[indexPath.section][indexPath.row]
        cell.iconImageView.image = UIImage(named: titlesArray[indexPath.section][indexPath.row])
//        if indexPath.item == 0{
//            //dashboard
//            cell.iconImageView.image = UIImage(named: "avatar")
//        }else if indexPath.item == 1{
//            // Appointments
//            cell.iconImageView.image = UIImage(named: "appointment")
//
//        }else{
//            cell.iconImageView.image = UIImage(named: "patient_Green")
//        }
        return cell
    }
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
  
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 0 {
            let outerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
            outerView.backgroundColor = .clear
            let seperator = UIView(frame: CGRect(origin: CGPoint(x: 8, y: 19), size: CGSize(width: tableView.frame.width - 16, height: 1)))
            outerView.addSubview(seperator)
            seperator.backgroundColor = UIColor(named: "BorderColor")
            return outerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 40
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sideMenuController = sideMenuController else { return }
        
        if indexPath.section == 1 && indexPath.row == 1 {
            //logout
            return
        }
        
        if indexPath.row == 0 {
            let viewController = DashboardViewController.instatiate(from: .Main)
            if let navigationController = sideMenuController.rootViewController as? RootNavigationController {
                navigationController.setViewControllers([viewController], animated: false)
            }
            sideMenuController.hideLeftView(animated: true, completion: nil)

//            if sideMenuController.isLeftViewAlwaysVisibleForCurrentOrientation{
////            if sideMenuController.isLeftViewAlwaysVisible {
//                sideMenuController.showRightView(animated: true, completion: nil)
//            }
//            else {
//                sideMenuController.hideLeftView(animated: true, completion: {
//                    sideMenuController.showRightView(animated: true, completion: nil)
//                })
//            }
        }
        else if indexPath.row == 2 {
            let viewController = AppointmentListViewController.instatiate(from: .Appointment)

            if let navigationController = sideMenuController.rootViewController as? RootNavigationController {
//                navigationController.pushViewController(viewController, animated: true)
                navigationController.setViewControllers([viewController], animated: false)
            }
            
//            guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "RootViewController") else { return }
//
//            if let navigationController = sideMenuController.rootViewController as? RootNavigationController {
//                navigationController.setViewControllers([viewController], animated: false)
//            }

            sideMenuController.hideLeftView(animated: true, completion: nil)
        }
        else {
            let viewController = MyPatientsListViewController.instatiate(from: .Appointment)

            if let navigationController = sideMenuController.rootViewController as? RootNavigationController {
//                navigationController.pushViewController(viewController, animated: true)
                navigationController.setViewControllers([viewController], animated: false)
            }
            
//            let viewController = UIViewController()
//            viewController.view.backgroundColor =  .white
//            viewController.title = "Test \(titlesArray[indexPath.row])"
//
//            if let navigationController = sideMenuController.rootViewController as? RootNavigationController {
//                navigationController.pushViewController(viewController, animated: true)
//            }
            
            sideMenuController.hideLeftView(animated: true, completion: nil)
        }
    }
    
    
}
