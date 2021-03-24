import UIKit
import Alamofire

class APIHandler: NSObject

{

    func callServiceMethodPOST(viewController : UIViewController, parameters : NSMutableDictionary? , keyURL : String, isShowLoader:Bool, isHideLoader:Bool, loadingMsg:String, completionBlock : @escaping ( _ resposeObject : NSDictionary? ,  _ error : NSError?)-> Void )
    {
        
        if Utility().isInternetAvailable(){
            
            let urlRequest = BASE_URL + keyURL
            
            print(urlRequest)
            print(parameters)
//            var waitSpiner : WaitView!
//
////            let waitSpiner = viewController.addWaitSpinner()
//            if isShowLoader
//            {
//                waitSpiner = viewController.addWaitSpinner()
////                viewController.removeWaitSpinner(waitView: waitSpiner)
//            }
            var headers : HTTPHeaders?
            
            if keyURL != ""{//LOGIN{
                let header = "PHPSESSID=" + Utility().getUSER_DEFAULTS_String(key: "Session_ID")
                headers = [ "Cookie": header]
            }
            

            Alamofire.request(urlRequest, method: .post, parameters: parameters as? [String : Any], encoding: JSONEncoding.default ,headers: headers ).responseJSON { response in
//
//                if (waitSpiner != nil){
//                    viewController.removeWaitSpinner(waitView: waitSpiner)
//                }

                print(response)
                
                    if response.result.isSuccess
                    {
                        completionBlock(response.result.value as? NSDictionary ,nil)
                    }
                    else
                    {
                        print(response.error)
                        
                        completionBlock(nil ,response.error as NSError?)

//                        viewController.displayMessage(title: "", msg: SERVER_MESSAGE)
                    }
                }
        }
        else
        {
            //viewController.displayMessage(title: "", msg: "Please Check Your Internet Connection And Try Again")
        }
    }
    
    
    func callServiceMethodUrlPOST(viewController : UIViewController, parameters : NSMutableDictionary? , keyURL : String, isShowLoader:Bool, isHideLoader:Bool, loadingMsg:String, completionBlock : @escaping ( _ resposeObject : NSDictionary? ,  _ error : NSError?)-> Void )
        {
            
            if Utility().isInternetAvailable(){
                
                let urlRequest = "https://app.biyah.pk/app1/" + keyURL
                
                print(urlRequest)
                print(parameters)
//                let waitSpiner = viewController.addWaitSpinner()
//                if !isShowLoader
//                {
//                    viewController.removeWaitSpinner(waitView: waitSpiner)
//                }
                                
                Alamofire.request(urlRequest, method: .post, parameters: parameters as? [String : Any], encoding: URLEncoding.default ,headers: nil).responseJSON { response in

                   // viewController.removeWaitSpinner(waitView: waitSpiner)

                        if response.result.isSuccess
                        {
                            completionBlock(response.result.value as? NSDictionary ,nil)
                        }
                        else
                        {
                            print(response.error)
                           // viewController.displayMessage(title: "", msg: SERVER_MESSAGE)
                        }
                    }
            }
            else
            {
               // viewController.displayMessage(title: "", msg: "Please Check Your Internet Connection And Try Again")
            }
        }

    
    
   
    func callServiceMethodGET(viewController : UIViewController, keyURL : String, isShowLoader:Bool, isHideLoader:Bool, loadingMsg:String, completionBlock : @escaping ( _ resposeObject : NSDictionary? ,  _ error : NSError?)-> Void )
    {
        if Utility().isInternetAvailable()
        {
        let urlString = BASE_URL + keyURL
           
            print(urlString)
            
//            let waitSpiner = viewController.addWaitSpinner()
//            if !isShowLoader
//            {
//                viewController.removeWaitSpinner(waitView: waitSpiner)
//            }
        
            
            
        let header = "PHPSESSID " + Utility().getUSER_DEFAULTS_String(key: "Session_ID")
        let headers = [ "Cookie": header]

            Alamofire.request(urlString, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
           //     viewController.removeWaitSpinner(waitView: waitSpiner)
        
                
            if response.result.isSuccess
            {
                completionBlock(response.result.value as? NSDictionary ,nil)
            }
            else
            {
                completionBlock(nil,response.result.error as NSError?)

//                Utility().showPositiveMessage(message: 1SERVER_MESSAGE)
            }
        }
    }
        else
        {
          //  viewController.displayMessage(title: "", msg: "Please Check Your Internet Connection And Try Again")
        }
    }
    
    func callServiceMethodDelete(viewController : UIViewController, parameters : NSMutableDictionary? , keyURL : String, isShowLoader:Bool, isHideLoader:Bool, loadingMsg:String, completionBlock : @escaping ( _ resposeObject : NSDictionary? ,  _ error : NSError?)-> Void )
    {
        
        if Utility().isInternetAvailable(){
            let urlRequest = BASE_URL + keyURL
            print(urlRequest)

            var headerToken = ""
            
            if let token : String = NSUSER_DEFAULTS.value(forKey: "token") as?  String
            {
                headerToken = token
            }
            else
            {
                headerToken = "Basic ZGVtb19vYXV0aF9jbGllbnQ6ZGVtb19vYXV0aF9zZWNyZXQ="
            }
            
            let headers = ["authorization" : headerToken]
            
//            let waitSpiner = viewController.addWaitSpinner()
//            if !isShowLoader
//            {
//                viewController.removeWaitSpinner(waitView: waitSpiner)
//            }
            
            Alamofire.request(urlRequest, method: .delete, parameters: parameters as? [String : Any], encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                   // viewController.removeWaitSpinner(waitView: waitSpiner)
                    print(response)
                    
                    
                    if response.result.isSuccess
                    {
                        completionBlock(response.result.value as? NSDictionary ,nil)
                    }
                    else
                    {
//                        viewController.displayMessage(title: "", msg: SERVER_MESSAGE)
                    }
            }
        }
        else
        {
           // viewController.displayMessage(title: "", msg: "Please Check Your Internet Connection And Try Again")
        }
    }
    
    
    
    
}
