//
//  ViewController.swift
//  date
//
//  Created by Kazakov Danil on 09.09.2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    let label = UILabel()
    let datePicker = UIDatePicker()
    let button = UIButton()
    
    var alarmDate = 0.0
    var count = 0
    var timer: Timer?
    var player = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        //Размер лейбла
        label.frame = CGRect(x: 0, y: 200, width: 200, height: 100)
        //Расположение лейбла
        label.center.x = view.center.x
        //расположение текста
        label.textAlignment = .center
        //закругление текста
        label.layer.cornerRadius = 15
        //цвет для границ
        label.layer.borderColor = UIColor.red.cgColor
        //толщина для границ
        label.layer.borderWidth = 2
        //толщина шрифта
        label.font = UIFont.systemFont(ofSize: 30)
        
        view.addSubview(datePicker)
        
        //size of label
        datePicker.frame = CGRect(x: 0, y: 300, width: 200, height: 100)
        //view center of label
        datePicker.center = view.center
        //задаем действие(селф потому что действие совершается с самим пикером.
        //datePickeraAction - это задаем название переменной действия
        datePicker.addTarget(self, action: #selector(datePickerAction(sender:)), for: .valueChanged)
        datePicker.preferredDatePickerStyle = .compact
        
        view.addSubview(button)
        
        //задаем размер для кнопки
        button.frame = CGRect(x: 9, y: view.frame.height - 300, width: 110, height: 48)
        //задаем название для кнопки
        button.setTitle("Start", for: .normal)
        //центруем кнопку
        button.center.x = view.center.x
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            
    }
    
    func createTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            if self.count == 0 {
                self.stopTimer()
                self.playSound()
            } else {
                self.count -= 1
                self.label.text = "\(self.count)"
            }
        })
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "FM9B3TC-alarm", withExtension: "mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
        } catch {
            print("error")
        }
        player.play()
    }
    
    func stopSound() {
        player.stop()
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    
    
    @objc func datePickerAction(sender: UIDatePicker) {
        alarmDate = sender.date.timeIntervalSince1970
    }
    
    @objc func buttonAction(sender: UIButton) {
        if sender.title(for: .normal)  == "Start" {
            sender.setTitle("Stop", for: .normal)
            count = Int(self.alarmDate) - Int(Date().timeIntervalSince1970)
            createTimer()
        } else {
            sender.setTitle("Start", for: .normal)
            stopSound()
        }
    }
}

