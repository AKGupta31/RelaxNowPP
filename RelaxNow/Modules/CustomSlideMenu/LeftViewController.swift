//
//  LeftViewController.swift
//  LGSideMenuControllerDemo
//

import Foundation
import UIKit
import LGSideMenuController
class LeftViewController: UIViewController {

    private var type: DemoType?
    
    private let titlesArray = [ "Dashboard",
                               "Patients",
                               "Appointments",]

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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeftViewCell

        cell.titleLabel.text = titlesArray[indexPath.row]
        if indexPath.item == 0{
            //dashboard
            cell.iconImageView.image = UIImage(named: "avatar")

        }else if indexPath.item == 1{
            // Appointments
            cell.iconImageView.image = UIImage(named: "appointment")

        }else{
            cell.iconImageView.image = UIImage(named: "patient_Green")
        }
        
//        cell.separatorView.isHidden = (indexPath.row <= 3 || indexPath.row == self.titlesArray.count-1)
//        cell.isUserInteractionEnabled = (indexPath.row != 1 && indexPath.row != 3)

        return cell
    }
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sideMenuController = sideMenuController else { return }
        
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
