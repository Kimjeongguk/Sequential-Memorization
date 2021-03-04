//
//  ButtonView.swift
//  Sequential Memorization
//
//  Created by Jeongguk Kim on 2021/02/25.
//

import UIKit


class ButtonView: UIStackView {
    var buttons: [UIButton] = []
    var stackview1 = UIStackView()
    var stackview2 = UIStackView()
    var stackview3 = UIStackView()
        
    public var click = 0{
        didSet{
            print(click)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUpButton()
    }
    
    func setUpButton(){
        self.axis = .vertical
        self.spacing = 1
        self.distribution = UIStackView.Distribution(rawValue: 1)!
        
        stackview1 = settingStackView()
        stackview2 = settingStackView()
        stackview3 = settingStackView()
        
        
        self.addArrangedSubview(stackview1)
        self.addArrangedSubview(stackview2)
        self.addArrangedSubview(stackview3)
        
        for index in 0..<9{
            let button = UIButton()
            
            button.tag = index
            button.addTarget(self, action: #selector(touchButton), for: .touchUpInside)
            button.setImage(UIImage(named: "emptyStar"), for: .normal)
            button.setImage(UIImage(named: "highlightedStar"), for: .highlighted)
            button.setImage(UIImage(named: "filledStar"), for: .selected)
            
            switch(index/3){
            case 0:
                stackview1.addArrangedSubview(button)
            case 1:
                stackview2.addArrangedSubview(button)
            case 2:
                stackview3.addArrangedSubview(button)
            default:
                break
            }
            buttons.append(button)
        }
        
    }
    
    func settingStackView() -> UIStackView{
        let stackView = UIStackView()
        
        stackView.distribution = UIStackView.Distribution(rawValue: 1)!
        stackView.spacing = 1
        
        return stackView
    }
    
    @objc func touchButton(sender: UIButton){
        click = sender.tag
    }
    
    
}
class bottomView: ButtonView{
    var view = ButtonView()
    var level = 1
    var randomNumbers = [Int]()
    public var tempValues = [Int]()
    
    override var click: Int{
        didSet{
            tempValues.append(click)
            clickButton(numbers: tempValues, view: view)
        }
    }
    func start(numbers: [Int], view: ButtonView){
        self.view = view
        randomNumbers = numbers
        DispatchQueue.global(qos: .default).async {
            self.showView(numbers: numbers, view: view)
        }
        
        
    }
    
    func showView(numbers: [Int], view: ButtonView){
        if level > 1{
            level = 1
            print("clear")
            DispatchQueue.main.async {
                self.isUserInteractionEnabled = false
            }
            return
        }
        for idx in 0..<level {
            DispatchQueue.main.async {
                self.isUserInteractionEnabled = false
                view.buttons[numbers[idx]].isSelected = true
            }
            usleep(600000)
            DispatchQueue.main.async {
                view.buttons[numbers[idx]].isSelected = false
            }
            usleep(400000)
        }
        DispatchQueue.main.async {
            self.isUserInteractionEnabled = true
        }
    }

    func clickButton(numbers: [Int], view: ButtonView){
        var valueList: [Int] = []
        for index in 0..<numbers.count{
            valueList.append(randomNumbers[index])
        }
        if level == valueList.count{
            if valueList.elementsEqual(tempValues){
                DispatchQueue.global(qos: .default).async {
                    usleep(300000)
                    self.level += 1
                    self.showView(numbers: self.randomNumbers, view: view)
                }
            }else{
//                tempValues = [Int]()
                DispatchQueue.global(qos: .default).async {
                    usleep(300000)
                    self.showView(numbers: self.randomNumbers, view: view)
                }
                print("일치하지않음")
            }
            tempValues = [Int]()
        }
    }
    
}
