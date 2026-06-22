import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!

    let locationManager = CLLocationManager()
    let middleLongitude = 34.817549168324334
    var hasLocation = false
    var playerSide = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        name.text = "Hi Player"
        startButton.isHidden = true

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    @IBAction func startButtonClicked(_ sender: UIButton) {

        let playerName = nameTextField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines)

        if playerName == nil || playerName == "" {
            name.text = "Hi Player"
            UserDefaults.standard.set("Player", forKey: "playerName")
        } else {
            name.text = "Hi \(playerName!)"
            UserDefaults.standard.set(playerName!, forKey: "playerName")
        }
        if hasLocation == false {
            name.text = "Waiting for location"
            return
        }
        performSegue(withIdentifier: "showGame", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGame" {
            let gameVC = segue.destination as! GameViewController
            gameVC.playerName = UserDefaults.standard.string(forKey: "playerName") ?? "Player"
            gameVC.playerSide = playerSide
            
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse ||
            manager.authorizationStatus == .authorizedAlways {
            manager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {

        guard let locationData = locations.first else { return }

        let longitude = locationData.coordinate.longitude

        if longitude > middleLongitude {
            playerSide = "East Side"
        } else {
            playerSide = "West Side"
        }
        hasLocation = true
        locationManager.stopUpdatingLocation()
        startButton.isHidden = false
    }

    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        
      
        startButton.isHidden = false
    }
}


