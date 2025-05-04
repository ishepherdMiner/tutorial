//
//  ViewController.swift
//  KVODemo
//
//  Created by Shepherd on 2025/5/3.
//

import UIKit

class Employee : NSObject {
    /// OC写法
    @objc dynamic var name:String?
}

class ViewController: UIViewController {
    var employee: Employee?
    var kvoToken: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        objcKVO()
        // swiftKVO()
    }
    
    func swiftKVO() {
        employee = Employee()
        employee?.name = "Wang"
        kvoToken = employee?.observe(\.name, options: .new) { (employee, change) in
            if let name = change.newValue {
                print("New name is:\(name ?? "")")
            }
        }
        employee?.name = "Li"
    }
    
    func objcKVO() {
        employee = Employee()
        employee?.name = "Wang"
        employee?.addObserver(self, forKeyPath: "name", options: .new, context:  nil)
        employee?.name = "Li"
    }
    
    /// OC写法
    override func observeValue(forKeyPath keyPath: String?,
                                   of object: Any?,
                                   change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if keyPath == "name" {
            if let name = change?[.newKey] {
                print("New name is:\(name)")
            }
        }
    }
    
    deinit {
        kvoToken?.invalidate()
        // employee?.removeObserver(self, forKeyPath: "name")
    }


}

