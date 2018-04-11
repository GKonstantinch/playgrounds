//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

/*---------------
 1. An instance method in Swift is just a type method
 that takes the instance as an argument
 and returns a function which will then be applied to the instance.
 
 2. Function that takes multiple parameters
 can be transformed into a chained series of functions
 that take one argument each.
 ---------------*/

class MyViewController : UIViewController {

    private let colors = [UIColor.red:"red", UIColor.blue:"blue"]
    private let picker = ColorPicker("ColorPicker initialized")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureColorPicker()
        printColor(picker.selectedColor)
        sleep(1)
        picker.pickColor(.red)
    }
    
    private func configureColorPicker() {
        /*---------------
         Note that we didn’t pass an argument after ViewController.colorPicked(_:) — we’re not calling the method here
         (which would yield an error because you can’t call an instance method on the type),
         just referencing it, much like a function pointer in C.
         The second step is then to call the function stored in the depositor variable.
         ----------------*/
        
        picker.addTarget(self,
                         action: MyViewController.colorPicked(_:))
        
        picker.addTargetForEvent(self,
                                 event: ColorPickerEvent.event1,
                                 action: MyViewController.colorPickedEvent1(_:))
        
        picker.addTargetForEvent(self,
                                 event: ColorPickerEvent.event2,
                                 action: MyViewController.colorPickedEvent2(_:))
        
        view.addSubview(picker)
    }
    
    private func colorPicked(_ picker: ColorPicker) {
        print("ColorPicked simple action detected")
        
        printColor(picker.selectedColor)
    }
    
    private func colorPickedEvent1(_ picker: ColorPicker) {
        print("ColorPicked action for event1 detected")
        
        printColor(picker.selectedColor)
    }
    
    private func colorPickedEvent2(_ picker: ColorPicker) {
        print("ColorPicked action for event2 detected")
        
        printColor(picker.selectedColor)
    }
    
    private func printColor(_ color: UIColor) {
        print("Current color - \(colors[color]!)");
    }
}

class ColorPicker: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("not implemented")
    }
    
    convenience init(_ printLog: String) {
        self.init(frame: CGRect.zero)
        print(printLog)
    }
    
    private(set) var selectedColor: UIColor = .blue {
        didSet {
            self.observationsWithEvents[ColorPickerEvent.event1]?.performAction()
            
            observations.forEach { observersAction in
                observersAction(self)
            }
            
            self.observationsWithEvents[ColorPickerEvent.event2]?.performAction()
        }
    }
    
    private var observationsWithEvents = [ColorPickerEvent : ColorPickerAction]()
    private var observations = [(ColorPicker) -> Void]()
    
    func addTarget<T: AnyObject>(_ target: T, action: @escaping Action<T, ColorPicker>) {
        observations.append { [weak target] ourInput in
            target.map(action)?(ourInput)
        }
    }
    
    func addTargetForEvent<T: AnyObject>(_ target: T?, event: ColorPickerEvent, action: @escaping Action<T, ColorPicker>) {
        guard let realTarget = target else {
            return
        }
        
        observationsWithEvents[event] = ColorPickerActionWrapper(target: realTarget, instance: self, action: action)
    }
    
    func pickColor(_ color: UIColor) {
        self.selectedColor = color
    }
}


typealias Action<Type, Input> = (Type) -> (Input) -> Void

enum ColorPickerEvent {
    case event1
    case event2
}

protocol ColorPickerAction {
    func performAction()
}


struct ColorPickerActionWrapper<T: AnyObject> : ColorPickerAction {
    weak var target: T?
    weak var instance: ColorPicker?
    let action: Action<T, ColorPicker>
    
    // init can be omited
    init(target: T?, instance: ColorPicker?, action: @escaping Action<T, ColorPicker>) {
        self.target = target
        self.instance = instance
        self.action = action
    }
    
    func performAction() -> () {
        if let t = target, let i = instance {
            action(t)(i)
        }
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
