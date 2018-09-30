//
//  WikiViewController.swift
//  Westeros
//
//  Created by Adrián Silva on 17/09/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import UIKit
import WebKit

final class WikiViewController: UIViewController {

    // MARK: - Properties
    private var model: House

    // MARK: - Outlets
    @IBOutlet weak var wikiWebView: WKWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    // MARK: - Initializers
    init(model: House) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        wikiWebView.navigationDelegate = self

        syncModelWithView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        title = ""

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(houseDidChange), name: .houseDidChangeNotification, object: nil)
    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self,
                                                  name: .houseDidChangeNotification,
                                                  object: nil)
    }
}

// MARK: - Private methods
private extension WikiViewController {
    private func syncModelWithView() {
        title = model.name
        let request = URLRequest(url: model.wikiUrl)
        spinner.startAnimating()
        wikiWebView.load(request)
    }

    @objc func houseDidChange(notification: Notification) {
        guard let info = notification.userInfo else { return }
        guard let model = info[kHouseKey] as? House else { return }
        self.model = model
        syncModelWithView()
    }
}

// MARK: - WebKit Delegate methods
extension WikiViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinner.stopAnimating()
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        switch navigationAction.navigationType {
        case .linkActivated, .formSubmitted, .formResubmitted:
            decisionHandler(.cancel)
        default:
            decisionHandler(.allow)
        }
    }
}


