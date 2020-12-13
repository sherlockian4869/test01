import Foundation
import UIKit

class Utilities {
    static func styleHelpedButton(_ button:UIButton) {
        button.backgroundColor = UIColor.init(red: 154/255, green: 205/255, blue: 50/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    
    static func styleSupportButton(_ button:UIButton) {
        button.backgroundColor = UIColor.init(red: 153/255, green: 255/255, blue: 153/255, alpha: 1)
        button.layer.cornerRadius = 20.0
        button.tintColor = UIColor.black
    }
    
    static func noButton(_ button:UIButton) {
        button.backgroundColor = UIColor.init(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        button.layer.cornerRadius = 20.0
    }
    
    static func styleHelpLabel(_ label:UILabel) {
        label.backgroundColor = UIColor.init(red: 153/255, green: 255/255, blue: 153/255, alpha: 0.3)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
    }
    
    static func styleTextField(_ textfield:UITextField) {
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0,y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
        
        textfield.borderStyle = .none
        
        textfield.layer.addSublayer(bottomLine)
    }
    
    static func styleFilledButton(_ button:UIButton) {
        button.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button:UIButton) {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
