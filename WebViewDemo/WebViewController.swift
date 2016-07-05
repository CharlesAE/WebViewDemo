//
//  WebViewController.swift
//  WebViewDemo
//
//  Created by Charles E on 7/5/16.
//  Copyright © 2016 SR Studios. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKScriptMessageHandler {
    
    var webView: WKWebView!
    var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        navItem()
        webItem()
        
    }
    
    func navItem(){
        navigationController?.navigationBar.translucent = false
        let titleLabel = UILabel(frame: CGRectMake(0, 0, view.frame.width - 32, view.frame.height))
        titleLabel.text = "Webview Demo"
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.whiteColor()
        navigationItem.titleView = titleLabel
    }
    
    
    func webItem(){
        let config = WKWebViewConfiguration()
        let contentController = WKUserContentController();
        let userScript = WKUserScript(
            source: "sendToSwift()",
            injectionTime: WKUserScriptInjectionTime.AtDocumentEnd,
            forMainFrameOnly: true)
        
        contentController.addUserScript(userScript)
        contentController.addScriptMessageHandler(
            self,
            name: "theHandler")
        config.userContentController = contentController
        webView = WKWebView(frame: CGRectZero, configuration: config)
        webView.opaque = false
        webView.backgroundColor = UIColor.lightGrayColor()
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : webView]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[v0]-100-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : webView]))
        
        let htmlFile: String = NSBundle.mainBundle().pathForResource("test", ofType: "html")!
        let url: NSURL = NSURL.fileURLWithPath(htmlFile)
        let request: NSURLRequest = NSURLRequest(URL: url)
        webView.loadRequest(request)
        
    }
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        if(message.name == "theHandler") {
            //Retrieve json data from angular and save it as NSDictionary
            let sentData = message.body as! NSDictionary
            
            //display data within an alertcontroller
            let alertController = UIAlertController(title: "JS Says", message: "You selected \(sentData.valueForKey("Choice") as! String)", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            })
            
            alertController.addAction(ok)
            
            presentViewController(alertController, animated: true, completion: nil)
            
        }
    }
    
}

