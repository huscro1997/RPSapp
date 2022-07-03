//
//  ViewController.swift
//  RPSapp
//
//  Created by 曾曜澤 on 2022/6/19.
//

import UIKit

class ViewController: UIViewController {
    //初始頁面
    @IBOutlet var startPage: UIView!
    @IBOutlet var playerImage: [UIImageView]!
    @IBOutlet var computerImage: [UIImageView]!
    @IBOutlet var computerChoose: UIView!
    @IBOutlet var playerChoose: UIView!
    
    //主頁面
    @IBOutlet var playerButton: [UIButton]!
    @IBOutlet var computerButton: [UIButton]!
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var computerScoreLabel: UILabel!
    @IBOutlet weak var playerWinLabel: UILabel!
    @IBOutlet weak var computerWinLabel: UILabel!
    @IBOutlet weak var noOneWinLabel: UILabel!
    //結束頁面
    @IBOutlet var endView: UIView!
    @IBOutlet weak var playerwonView: UIView!
    @IBOutlet weak var computerWonView: UIView!
    
    var computer = ""
    var computerScore = 0
    var player = ""
    var playerIndex = 0
    var playerScore = 0
    var time = Timer()
    @objc var seconds = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //開始畫面
        randomPlayer()
        playerChoose.isHidden = true
        computerChoose.isHidden = true
        startPage.isHidden = false
        playerWinLabel.isHidden = true
        computerWinLabel.isHidden = true
        countDownLabel.isHidden = true
        noOneWinLabel.isHidden = true
        //結束畫面
        endView.isHidden = true
        playerwonView.isHidden = true
        computerWonView.isHidden = true
    }
    
    //初始畫面選角色
    func randomPlayer() {
        let num = Int.random(in: 1...7)
        for i in 0...2 {
            playerImage[i].image = UIImage(named: "L\(num)")
            computerImage[i].image = UIImage(named: "R\(num)")
        }
    }
    //選擇角色
    @IBAction func player0(_ sender: UIButton) {
        playerChoose.isHidden = false
    }
    @IBAction func computer0(_ sender: UIButton) {
        computerChoose.isHidden = false
    }
    
    //玩家
    @IBAction func player1(_ sender: UIButton) {
        var num = 0
        num = Int((sender.titleLabel?.text)!)!
        for i in 0...2 {
            playerImage[i].image = UIImage(named: "L\(num + 1)")
        }
        playerChoose.isHidden = true
    }
    //電腦
    @IBAction func computer1(_ sender: UIButton) {
        var num = 0
        num = Int((sender.titleLabel?.text)!)!
        for i in 0...2 {
            computerImage[i].image = UIImage(named: "R\(num + 1)")
        }
        computerChoose.isHidden = true
    }
    
    //開始遊戲
    @IBAction func start(_ sender: UIButton) {
        startPage.isHidden = true
    }
    
    
    
    
    
    //玩家獲勝
    func playerWin() {
        playerScore += 1
        playerScoreLabel.text = "\(playerScore)"
        playerWinLabel.isHidden = false
    }
    //電腦獲勝
    func computerWin() {
        computerScore += 1
        computerScoreLabel.text = "\(computerScore)"
        computerWinLabel.isHidden = false
    }
    //平手
    func noWin() {
        noOneWinLabel.isHidden = false
    }
    //分數到達五分
    func scoreTo5() {
        if playerScore == 5 {
            endView.isHidden = false
            playerwonView.isHidden = false
        } else if computerScore == 5 {
            endView.isHidden = false
            computerWonView.isHidden = false
        }
    }
    //猜完拳倒數秒數
    @objc func countDown() {
        seconds -= 1
        countDownLabel.text = "\(seconds)"
        if seconds == 0 {
            countDownLabel.isHidden = true
            time.invalidate()
            for i in 0...2 {
            computerButton[i].configuration?.background.strokeColor = UIColor.gray
            playerButton[i].configuration?.background.strokeColor = UIColor.gray
                computerWinLabel.isHidden = true
                playerWinLabel.isHidden = true
                noOneWinLabel.isHidden = true
                for choiceButton in playerButton {
                            choiceButton.isUserInteractionEnabled = true
                        }
            }
            scoreTo5()
        }
    }
    
    
    //電腦猜拳
    func computerRPS(c:Int) {
        computerButton[c].configuration?.background.strokeColor = UIColor.green
        computer = (computerButton[c].titleLabel?.text)!
    }
    //玩家猜拳
    @IBAction func RPSGame(_ sender: UIButton) {
        seconds = 3
        let computerIndex = Int.random(in: 0...2)
        computerRPS(c: computerIndex)
        let number = Int((sender.titleLabel?.text)!)
        playerIndex = number!
        if playerIndex == 0 {
            player = "剪刀"
        } else if playerIndex == 1 {
            player = "石頭"
        } else if playerIndex == 2 {
            player = "布"
        }
        let num = playerIndex
        playerButton[num].configuration?.background.strokeColor = UIColor.green
        if player == "剪刀", computer == "剪刀" {
            noWin()
        } else if player == "剪刀", computer == "石頭" {
            computerWin()
        } else if player == "剪刀", computer == "布" {
            playerWin()
        } else if player == "石頭", computer == "剪刀" {
            playerWin()
        } else if player == "石頭", computer == "石頭" {
            noWin()
        } else if player == "石頭", computer == "布" {
            computerWin()
        } else if player == "布", computer == "剪刀" {
            computerWin()
        } else if player == "布", computer == "石頭" {
            playerWin()
        } else if player == "布", computer == "布" {
            noWin()
        }
        for choiceButton in playerButton {
                    choiceButton.isUserInteractionEnabled = false
                }
        countDownLabel.isHidden = false
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        countDown()
    }
    @IBAction func replay(_ sender: UIButton) {
        //開始畫面
        startPage.isHidden = false
        //遊戲畫面
        playerWinLabel.isHidden = true
        computerWinLabel.isHidden = true
        countDownLabel.isHidden = true
        noOneWinLabel.isHidden = true
        playerScore = 0
        computerScore = 0
        playerScoreLabel.text = "0"
        computerScoreLabel.text = "0"
        //結束畫面
        endView.isHidden = true
        playerwonView.isHidden = true
        computerWonView.isHidden = true
    }
    

}

