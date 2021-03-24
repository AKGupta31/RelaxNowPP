import UIKit
import CoreLocation
import QuickLook
import CoreLocation
import MobileCoreServices

class Utility: NSObject
{
    
    static let sharedInstance = Utility()
    
//    MARK:- IS Valid Email
    func isValidEmail(testStr:String) -> Bool
    {
        //        print("validate emilId: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
        
    }
    
    //    MARK:- IS Valid Phone
    func isValidPhone(testStr:String) -> Bool{
         let regularExpressionForPhone = "[2356789][0-9]{6}([0-9]{3})?"
         let testPhone = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPhone)
         return testPhone.evaluate(with: testStr)
    }
    
    //    MARK:- IS Valid Password
    func isValidPassword(testPwd : String?) -> Bool
    {
        guard testPwd != nil else
        {
            return false
        }
//        "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{8,}$" with special character

        let passwordPred = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}$")
        return passwordPred.evaluate(with: testPwd)
    }
    
    //    MARK:- get Reponse String
    
    func getUSER_DEFAULTS_String(key : String) -> String
    {
        var returnString = ""
        if let keyValue : Int = NSUSER_DEFAULTS.value(forKey: key) as? Int
        {
            returnString = String(keyValue)
        }
        if let keyValueStr : String = NSUSER_DEFAULTS.value(forKey: key) as? String
        {
            returnString = keyValueStr
        }
        return returnString
    }
    
    
    //    MARK:- Get String Response
    func getresponseString(dataDict : NSDictionary,key : String) -> String
    {
        var returnString = ""
        if let keyValue : Int = dataDict.value(forKey: key) as? Int
        {
            returnString = String(keyValue)
        }
        else if let keyValueStr : String = dataDict.value(forKey: key) as? String
        {
            returnString = keyValueStr
        }
        else if let keyValueDouble : Double = dataDict.value(forKey: key) as? Double
        {
            returnString = String(keyValueDouble)
        }
        return returnString
    }
    
    //  MARK:- Capitalize first String
    func capitalizingFirstLetter(str:String) -> String {
        if str != ""
        {
            let first = String(str.prefix(1)).capitalized
            let other = String(str.dropFirst())
            return first + other
        }
        else
        {
            return str
        }
    }
    
    //    MARK:- Compare Equal Ignore Two String
    
    func CompareEqualIgnoreString(firstString : String, SecondStr : String) -> Bool
    {
        if (firstString.caseInsensitiveCompare(SecondStr) == ComparisonResult.orderedSame)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
//    MARK:- Device IS Ipad
    
    func isIpad()-> Bool
    {
        if ( UI_USER_INTERFACE_IDIOM() == .pad )
        {
            return true; /* Device is iPad */
        }
        else
        {
            return false
        }
    }
    
    
//    MARK:- Alert Message
    
    func showAlert(Title: String, message: String,viewcontroller : UIViewController, callback:@escaping (()->()) )
    {
        let alertController = UIAlertController(title: Title, message: message, preferredStyle: .alert)
        let yesPressed = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            callback()
        })
        alertController.addAction(yesPressed)
        viewcontroller.present(alertController, animated: true, completion: nil)
    }
    

    //MARK:- CheckInternetCOnnection
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }

    
    func changePlaceholderTetxColor(textField : UITextField , title : String,color:UIColor)
    {
        textField.attributedPlaceholder = NSAttributedString(string:title, attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
    func setBorder(borderWidth:CGFloat,borderColor:UIColor,view:UIView)
    {
        view.layer.borderColor = borderColor.cgColor
        view.layer.borderWidth = borderWidth;
    }
    
    func setCornerRaduis(cornerRadius:CGFloat,view:UIView)
    {
        view.layer.cornerRadius = cornerRadius;
        view.clipsToBounds = true;
    }
    
    func setRoundCorner(view:UIView)
    {
        view.layer.cornerRadius = view.frame.size.height/2;
        view.clipsToBounds = true;
    }
    
//    MARK:- Set Shadow
    func setShadow(shadowOffset:CGSize,shadowColor:UIColor,view:UIView, shadowRadius : CGFloat, shadowOpacity : Float)
    {
        view.layer.shadowOffset = shadowOffset
        view.layer.shadowRadius = shadowRadius
        view.layer.shadowOpacity = shadowOpacity;
        view.layer.shadowColor = shadowColor.cgColor
        view.alpha = 1
        view.layer.shouldRasterize = true
        view.layer.masksToBounds = false
    }

    //    MARK:- Remove Gradient
    
    func removeGradientLayer(view:UIView)
    {
        if let v = view.viewWithTag(12255){
            v.removeFromSuperview()
        }
    }


//    func showAlertWithMessage(message: String, title: String, view : UIView)
//    {
//        ToastManager.shared.queueEnabled = true
//        var style = ToastStyle()
//        if self.isIpad()
//        {
//            style.messageFont = UIFont(name: "SourceSansPro-Semibold", size: 25.0)!
//        }
//        else
//        {
//            style.messageFont = UIFont(name: "SourceSansPro-Semibold", size: 15.0)!
//        }
//        style.messageColor = UIColor.white
//        style.messageAlignment = .center
//        style.backgroundColor =  UIColor.black.withAlphaComponent(0.8)
//        view.makeToast(message, duration: 3.0, position: .bottom, style: style)
//    }
    
    //MARK:- getOSInfo()
    func getOSInfo()->String
    {
        let os = ProcessInfo().operatingSystemVersion
        return String(os.majorVersion) + "." + String(os.minorVersion) + "." + String(os.patchVersion)
    }
    
    func setPaddingOnTextFeild(textFeild:UITextField)
    {
        let paddingView : UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: textFeild.frame.size.height))
        textFeild.leftView = paddingView
        textFeild.leftViewMode = .always
    }
    
    func addPlaceholderOnTextVIew(texview:UITextView,lbl:UILabel,lblText:String,color:UIColor)
    {
        lbl.text = lblText
        lbl.font = UIFont(name: "SourceSansPro-Semibold", size: 15.0)
        texview.textContainerInset = .zero
        texview.contentInset = UIEdgeInsets(top: -2, left: -5, bottom: 0, right: 0)
        texview.addSubview(lbl)
        lbl.frame  = CGRect(x: 5, y:-2, width: texview.frame.size.width, height: 30)
        lbl.textColor = color
    }

    
}
