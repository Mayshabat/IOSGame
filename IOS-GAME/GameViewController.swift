import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var player0Label: UILabel!
    @IBOutlet weak var pcLabel: UILabel!
    @IBOutlet weak var pc0Label: UILabel!
    @IBOutlet weak var timerLabel: UILabel!

    @IBOutlet weak var playerCardImageView: UIImageView!
    @IBOutlet weak var pcCardImageView: UIImageView!

    var playerName = "Player"

    var playerScore = 0
    var pcScore = 0
    var round = 0
    var seconds = 5
    var timer: Timer?

    let cards = [
        ("069-four of hearts", 4),
        ("070-five of hearts", 5),
        ("071-six of hearts", 6),
        ("072-seven of hearts", 7),
        ("073-eight of hearts", 8),
        ("074-nine of spades", 9),
        ("075-ten of spades", 10),
        ("076-jack of spades", 11),
        ("077-jack of hearts", 11),
        ("078-queen of hearts", 12),
        ("079-queen of hearts", 12),
        ("080-king of hearts", 13),
        ("081-king of hearts", 13),
        ("082-ace of clubs", 14),
        ("083-two of clubs", 2),
        ("084-three of clubs", 3),
        ("085-four of clubs", 4),
        ("086-five of clubs", 5),
        ("087-six of clubs", 6),
        ("088-seven of clubs", 7),
        ("089-eight of clubs", 8),
        ("090-nine of clubs", 9),
        ("091-ten of clubs", 10),
        ("092-jack of clubs", 11),
        ("093-jack of clubs", 11),
        ("094-queen of clubs", 12),
        ("095-queen of clubs", 12),
        ("096-king of clubs", 13),
        ("097-king of clubs", 13),
        ("098-ace of diamonds", 14),
        ("099-two of diamonds", 2),
        ("100-three of diamonds", 3),
        ("101-four of diamonds", 4),
        ("102-five of diamonds", 5),
        ("103-six of diamonds", 6),
        ("104-seven of diamonds", 7),
        ("105-eight of diamonds", 8),
        ("106-nine of diamonds", 9),
        ("107-ten of diamonds", 10),
        ("108-jack of diamonds", 11),
        ("109-jack of diamonds", 11),
        ("110-queen of diamonds", 12),
        ("111-queen of diamonds", 12),
        ("112-king of diamonds", 13)
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        playerName = UserDefaults.standard.string(forKey: "playerName") ?? "Player"

        playerLabel.text = playerName
        player0Label.text = "0"
        pcLabel.text = "PC"
        pc0Label.text = "0"
        timerLabel.text = "5"

        startGame()
    }

    func startGame() {

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }

            self.seconds -= 1
            self.timerLabel.text = "\(self.seconds)"

            if self.seconds == 0 {
                self.seconds = 5
                self.playRound()
            }
        }
    }

    func playRound() {

        if round >= 10 {
            timer?.invalidate()
            timer = nil
            goToResultScreen()
            return
        }

        round += 1
        seconds = 5
        timerLabel.text = "5"

        let playerCard = cards.randomElement()!
        var pcCard = cards.randomElement()!

        while playerCard.0 == pcCard.0 {
            pcCard = cards.randomElement()!
        }

        playerCardImageView.image = UIImage(named: playerCard.0)
        pcCardImageView.image = UIImage(named: pcCard.0)

        if playerCard.1 > pcCard.1 {
            playerScore += 1
        } else if pcCard.1 > playerCard.1 {
            pcScore += 1
        }

        player0Label.text = "\(playerScore)"
        pc0Label.text = "\(pcScore)"
    }

    func goToResultScreen() {

        timer?.invalidate()
        timer = nil

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let resultVC = storyboard.instantiateViewController(
            withIdentifier: "ResultViewController"
        ) as! ResultViewController

        if playerScore > pcScore {
            resultVC.winnerText = "Winner: \(playerName)"
            resultVC.scoreText = "score: \(playerScore)"
        } else if pcScore > playerScore {
            resultVC.winnerText = "Winner: PC"
            resultVC.scoreText = "score: \(pcScore)"
        } else {
            resultVC.winnerText = "It's a Tie"
            resultVC.scoreText = "score: \(playerScore)"
        }

        resultVC.modalPresentationStyle = .fullScreen
        present(resultVC, animated: true)
    }
}
