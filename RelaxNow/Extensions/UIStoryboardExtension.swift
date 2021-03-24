//
//  UIStoryboardExtension.swift
//  RelaxNow
//
//  Created by Pritrum on 04/03/21.
//

import UIKit
enum Storyboard : String {
    case Main = "Main"
    case Appointment = "Appointment"
    
    var instance : UIStoryboard {
      return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass : T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
    
    // USAGE :
//    let controller = ClassName.instatiate(from: .Appointment)

    
}

extension UIViewController{
    class var storyboardID: String{
        return "\(self)"
    }
    
    static func instatiate(from storyboard: Storyboard) -> Self{
        return storyboard.viewController(viewControllerClass: self)
    }
}

