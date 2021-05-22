//
//  Rrawer.swift
//  wyw
//
//  Created by Xiaoshiheng_pro on 2017/2/24.
//  Copyright © 2017年 XIAO. All rights reserved.
//

import UIKit

class Rrawer: NSObject {
    
 
    
   class func logClient(window : UIWindow) {
       
    window.rootViewController = DRrawerViewController.drawerWithViewController(_leftViewcontroller:LetTableViewController.init(),_mainViewController: MainViewController.init(),DrawerMaxWithd: 300)
        
        window.makeKeyAndVisible()
        
    }
    
    

}
