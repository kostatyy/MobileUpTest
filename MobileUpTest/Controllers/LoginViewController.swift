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
    
    private var viewModel = LoginViewModel()
    private var authNavController: UINavigationController!
    
    //MARK: - VK Web View
    private var vkWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        loginButton.layer.cornerRadius = loginButton.frame.height * 0.2
        loginButton.titleLabel?.font = UIFont.setFont(size: .Medium, weight: .semibold)
        topLabel.font = UIFont.setFont(size: .Big, weight: .bold)
    }
    
    //MARK: - Open VK Authorization Screen
    @IBAction func loginToVK(_ sender: UIButton) {
        vkWebView = WKWebView()
        self.vkAuthVC(vkWebView: vkWebView)
    }
}

extension LoginViewController: WKNavigationDelegate {
    
    //MARK: - Show VK Login Screen
    func vkAuthVC(vkWebView: WKWebView) {
        let vkVC = UIViewController()
        
        vkWebView.navigationDelegate = self
        vkVC.view.addSubview(vkWebView)
        vkWebView.frame = vkVC.view.bounds
        vkWebView.translatesAutoresizingMaskIntoConstraints = false
        
        guard let url = VKManager.shared.signInUrl else { return }
        let urlRequest = URLRequest.init(url: url)
        vkWebView.load(urlRequest)
        
        authNavController = UINavigationController(rootViewController: vkVC)
        authNavController.setNavigationBarHidden(true, animated: false)
        
        self.present(authNavController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        viewModel.requestForCallbackURL(request: navigationAction.request) { result in
            DispatchQueue.main.async {
                self.dismiss(animated: true) {
                    if let result = result {
                        self.callErrorAlert(message: result)
                    } else {
                        let galleryVC: GalleryViewController = .instantiate()
                        self.navigationController?.pushViewController(galleryVC, animated: true)
                    }
                }
            }
        }
        
        decisionHandler(.allow)
    }
    
    //MARK: - Handling Auth Errors
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let message: String = error.localizedDescription
        authNavController.callErrorAlert(message: message)
    }
}
