import UIKit

class TabBarController: UITabBarController {
    
    override class func initialize() {
        var attrs = [String: NSObject]()
        attrs[NSForegroundColorAttributeName] = UIColor(r: 87, g: 206, b: 138)
        // 设置tabBar字体颜色
        UITabBarItem.appearance().setTitleTextAttributes(attrs, for:.selected)
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewControllers()
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 49))
        backView.backgroundColor = UIColor.white
        tabBar.insertSubview(backView, at: 0)
        tabBar.isOpaque = true
    }

    // MARK: - private method
    /// 添加所有子控制器
    func addChildViewControllers() {
        
        setupOneChildViewController("首页", image: "hml_home_nor", selectedImage: "hml_home_select", controller: HomeVC.init())
        setupOneChildViewController("搜索", image: "hml_search_nor", selectedImage: "hml_search_select", controller: SearchVC.init())
        setupOneChildViewController("购物车", image: "hml_shopcart_nor", selectedImage: "hml_shopcart_select", controller: ShoppingCartVC.init())
        setupOneChildViewController("个人中心", image: "hml_profile_nor", selectedImage: "hml_profile_select", controller: ProfileVC.init())
        
    }
    
    /// 添加一个子控制器
    fileprivate func setupOneChildViewController(_ title: String, image: String, selectedImage: String, controller: UIViewController) {
        
        controller.tabBarItem.title = title
        controller.title = title
        controller.view.backgroundColor = BGCOLOR
        controller.tabBarItem.image = UIImage(named: image)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        controller.tabBarItem.selectedImage = UIImage(named: selectedImage)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        let naviController = NavigationController.init(rootViewController: controller)
        addChildViewController(naviController)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
