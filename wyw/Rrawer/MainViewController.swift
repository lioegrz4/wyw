//
//  QQMainViewController.swift
//  QQDRAWER_SWIFT
//
//  Created by zzy on 2016/10/30.
//  Copyright © 2016年 BlackSky. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 1
        view.layer.shadowOffset = CGSize(width: -1, height: -1)
        view.layer.shadowOpacity = 0.8
        
        let sb = UIStoryboard(name: "Main", bundle:nil)
        
        let vcHomeViewController : UIViewController?
//        vcHomeViewController = HomeViewController.init()
        vcHomeViewController = MPViewController.init()
//            sb.instantiateViewController(withIdentifier: "MPViewController")
        self.addChildViewController(vcHomeViewController!, "美拍", defaultImageName: "tab_recent_nor",selectedImageName: "tab_recent_press")
        
        let vcVodViewController : UIViewController?
        vcVodViewController = sb.instantiateViewController(withIdentifier: "VodViewController")
        self.addChildViewController(vcVodViewController!, "直播", defaultImageName: "tab_recent_nor",selectedImageName: "tab_recent_press")


    }
    
    func addChildViewController(_ childController: UIViewController,_ title: NSString, defaultImageName: NSString, selectedImageName: NSString) {
        
        let navViewController = UINavigationController.init(rootViewController: childController)
        
        self.addChildViewController(navViewController)
        
        childController.tabBarItem.image = UIImage.init(named: defaultImageName as String)
        childController.tabBarItem.selectedImage = UIImage.init(named: selectedImageName as String)
        
        childController.title = title as String
        
        if title.isEqual(to: "消息") {
            
            childController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "run10"), style: .plain , target: self, action: (#selector(MainViewController.openDrawer)))
        }
    }
    
    
    /// 打开抽屉效果
    func openDrawer(){
        DRrawerViewController.sharedDrawerViewController.openDrawer(openDrawerWithDuration: 0.2)
    }
    
    /// 遮罩按钮手势的回调
    ///
    /// - parameter pan: 手势
    func panGestureRecognizer(pan: UIPanGestureRecognizer) {
        DRrawerViewController.sharedDrawerViewController.panGestureRecognizer(pan: pan)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
