//
//
//
//  Created by Michele De Sena on 20/08/18.
//  Copyright © 2018 Michele De Sena. All rights reserved.
//

import UIKit
import WebKit

class AvvisiWebViewController: UIViewController {
    
    
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url =  URL(string: "http://www.air-spa.it/avvisi.php")
        let request:URLRequest = URLRequest(url: url!)
        webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.109 Safari/537.36"
//        webView.uiDelegate = self
        webView.load(request)
        view.bringSubviewToFront(webView)
        
    }
}
