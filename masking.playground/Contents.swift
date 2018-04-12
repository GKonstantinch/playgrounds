//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let replica = CircleGradientLayerView(frame: CGRect(x: 30, y: 30, width: 300, height: 300))
        replica.backgroundColor = .clear
        self.view.addSubview(replica)
    }
}

class CircleGradientLayerView: UIView {
    
    let dotSize: CGFloat = 20
    let dotsCount: Int = 25
    
    override func draw(_ rect: CGRect) {
        let dot = CALayer()
        dot.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: dotSize, height: dotSize))
        dot.position = CGPoint(x: dotSize, y: rect.height/2)
        dot.cornerRadius = dotSize/2
        dot.backgroundColor = UIColor.black.cgColor
        
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 1
        fadeOut.toValue = 0
        fadeOut.duration = 1
        fadeOut.repeatCount = Float.greatestFiniteMagnitude

        dot.add(fadeOut, forKey: nil)
        
        let shrinkAnimation = CABasicAnimation(keyPath: "transform.scale")
        shrinkAnimation.fromValue = 1
        shrinkAnimation.toValue = 0.1
        shrinkAnimation.duration = 1
        shrinkAnimation.repeatCount = Float.greatestFiniteMagnitude
        
        dot.add(shrinkAnimation, forKey: nil)
        
        let replicator = CAReplicatorLayer()
        replicator.frame = rect
        replicator.instanceCount = dotsCount
        replicator.instanceDelay = 1 / CFTimeInterval(dotsCount)
        replicator.instanceTransform = CATransform3DMakeRotation((.pi * 2 / CGFloat(dotsCount)), 0, 0, 1)
        
        replicator.addSublayer(dot)
        
        let gradient = CAGradientLayer()
        gradient.frame = rect
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.colors = [UIColor(red: 0.96, green: 0.82, blue: 0.26, alpha: 1.00).cgColor,
                           UIColor(red: 0.95, green: 0.47, blue: 0.19, alpha: 1.00).cgColor,
                           UIColor(red: 0.73, green: 0.26, blue: 0.53, alpha: 1.00).cgColor,
                           UIColor(red: 0.34, green: 0.19, blue: 0.53, alpha: 1.00).cgColor]
        
        gradient.mask = replicator
        
        self.layer.addSublayer(gradient)
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
