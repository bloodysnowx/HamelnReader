import UIKit

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let menu = UIImage(named: "menu") {
            self.addLeftBarButtonWithImage(menu)
            self.addRightBarButtonWithImage(menu)
        }
    }
}
