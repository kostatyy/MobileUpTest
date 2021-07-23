//
//  LoginViewController.swift
//  MobileUpTest
//
//  Created by Macbook Pro on 22.07.2021.
//

import UIKit
import WebKit

class LoginViewController: UIViewController {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel = LoginViewModel()
    
    /* VK Web View */
    private var vkWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        loginButton.layer.cornerRadius = 15
        loginButton.titleLabel?.font = UIFont.setFont(size: .Medium, weight: .semibold)
        topLabel.font = UIFont.setFont(size: .Big, weight: .bold)
    }
    
    // Open VK Authorization Screen
    @IBAction func loginToVK(_ sender: UIButton) {
        vkWebView = WKWebView()
        self.vkAuthVC(vkWebView: vkWebView)
    }
}

extension LoginViewController: WKNavigationDelegate {
    
    /* Show VK Login Screen */
    func vkAuthVC(vkWebView: WKWebView) {
        // Create VK Auth ViewController
        let vkVC = UIViewController()
        
        vkWebView.navigationDelegate = self
        vkVC.view.addSubview(vkWebView)
        vkWebView.frame = vkVC.view.bounds
        vkWebView.translatesAutoresizingMaskIntoConstraints = false
        
        guard let url = VKManager.shared.signInUrl else { return }
        print(url)
        let urlRequest = URLRequest.init(url: url)
        vkWebView.load(urlRequest)
        
        // Create Navigation Controller
        let navController = UINavigationController(rootViewController: vkVC)
        navController.setNavigationBarHidden(true, animated: false)
        
        self.present(navController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        viewModel.requestForCallbackURL(request: navigationAction.request) {
            self.dismiss(animated: true, completion: nil)
        }
        
        decisionHandler(.allow)
    }
}
