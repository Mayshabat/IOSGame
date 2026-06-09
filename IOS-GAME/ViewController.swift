//
//  ViewController.swift
//  IOS-GAME
//
//  Created by Student14 on 08/06/2026.
//
import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var insertNameButton: UIButton!

    let locationManager = CLLocationManager()
    let middleLongitude = 34.817549168324334

    override func viewDidLoad() {
        super.viewDidLoad()

        if let savedName = UserDefaults.standard.string(forKey: "playerName"),
           !savedName.isEmpty {

            name.text = "Hi \(savedName)"
            insertNameButton.isHidden = true

        } else {

            name.text = ""
            insertNameButton.isHidden = false
        }

        startButton.isHidden = true

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    @IBAction func insertNamePressed(_ sender: UIButton) {

        let alert = UIAlertController(
            title: "Insert Name",
            message: "Please enter your name",
            preferredStyle: .alert
        )

        alert.addTextField()

        alert.addAction(UIAlertAction(title: "Save", style: .default) { _ in

            let playerName = alert.textFields?[0].text ?? ""

            self.name.text = "Hi \(playerName)"
            self.insertNameButton.isHidden = true

            UserDefaults.standard.set(playerName, forKey: "playerName")
        })

        present(alert, animated: true)
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
            location.text = "Your side: East Side"
        } else {
            location.text = "Your side: West Side"
        }

        startButton.isHidden = false
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {

        location.text = "Location Error"
        startButton.isHidden = true
    }
}
