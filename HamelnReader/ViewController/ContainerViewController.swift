import UIKit
import SlideMenuControllerSwift

class ContainerViewController: SlideMenuController {
    override func awakeFromNib() {
        self.leftViewController = self.storyboard?.instantiateViewController(withIdentifier: "Left")
        self.mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "Main")
        self.rightViewController = self.storyboard?.instantiateViewController(withIdentifier: "Right")

        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
