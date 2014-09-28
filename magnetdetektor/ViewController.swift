//
//  ViewController.swift
//  magnetdetektor
//
//  Created by Michael Fuhrmann on 28.09.14.
//  Copyright (c) 2014 EasterBunny Vs SantaClaus. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    //Labels & ProgressBar initialisieren bzw. definieren
    @IBOutlet weak var labelStatusText: UILabel!
    @IBOutlet weak var labelStatusZahl: UILabel!
    @IBOutlet var progressStatusBar: UIProgressView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.startUpdatingHeading()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        let magnitude:Double = sqrt(pow(newHeading.x, 2) + pow(newHeading.y, 2) + pow(newHeading.z, 2))
        let magnitudeRatio = Float(magnitude) / 600
        progressStatusBar.progress = magnitudeRatio
        
        //Link: http://www.cocoa-coding.de/zeichenketten/nsstring.html
        var formatter:NSString = NSString(format: "%.3f", magnitudeRatio)
        
        labelStatusZahl.text = formatter
        
        //Labeltext setzen (Kann ev. ausgelagert werden!?)
        if magnitudeRatio > 2 {
            labelStatusText.text = "Grossen Magnet gefunden :D"
        } else if magnitudeRatio > 0.9 {
            labelStatusText.text = "Magnet gefunden :)"
        } else {
            labelStatusText.text = "Keinen Magnet gefunden :("
        }
    }
    
    @IBAction func buttonReset(sender: AnyObject) {
        labelStatusZahl.text = "0.000"
    }
}

