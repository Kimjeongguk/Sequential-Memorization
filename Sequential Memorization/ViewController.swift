//
//  ViewController.swift
//  Sequential Memorization
//
//  Created by Jeongguk Kim on 2021/02/25.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var topView: ButtonView!
    @IBOutlet var bottomView: bottomView!
    var numbers: [Int] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.isUserInteractionEnabled = false
        bottomView.isUserInteractionEnabled = false
        numbers = randomNumber(count: 1)
        
    }

    @IBAction func startButton(_ sender: Any) {
        bottomView.start(numbers: numbers, view: topView)
        
        
    }
    @IBAction func resetButton(_ sender: Any) {
        numbers = randomNumber(count: 1)
    }
    
    func randomNumber(count: Int) -> [Int]{
        var numbers: [Int] = []
        
        for _ in 0..<count{
            let number = Int.random(in: 0..<9)
            numbers.append(number)
        }
        print(numbers)
        return numbers
    }
}
