//
//  ViewController.swift
//  ProyectoJorge
//
//  Created by Usuario on 17/01/2023.
//  Copyright © 2023 Jorge. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var resultado: UILabel!
    @IBOutlet weak var boton: UIButton!
    var player : AVAudioPlayer!
    var color = ""
    var parte = ""
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            do {
                        // desenvolviendo una variable (unwrapping var)
                        if let fileURL = Bundle.main.path(forResource: "los-clics_1", ofType:"mp3") {
                            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
                        } else {
                            print("No existe fichero de sonido")
                        }
            } catch let error {
                        print("Error en la carga del sonido \(error.localizedDescription)")
            }
            self.loadAnimation()
        }
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        @IBAction func pulsar(_ sender: UIButton) {
            imagen.startAnimating()
            if let player = player{
                        player.play()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute:{
                self.imagen.stopAnimating()
                self.player.stop()
                self.inventaypinta()
            })
        }
        func loadAnimation() {
            
            imagen.animationImages = [UIImage]()
            for index in 0 ..< 4 {
                let frameName = "imagen\(index)"
                imagen.animationImages?.append(UIImage(named: frameName)!)
                cambiarColor(number: index)
                
            }
            

            imagen.animationDuration = 0.6
            
        }
        func inventaypinta() {
            var n = Int(arc4random() % 4);
            let image = UIImage(named: "imagen\(n)")
            switch n {
            case 0:
                parte = "Mano derecha "
            case 1:
            parte = "Mano izquierda "
            case 2:
            parte = "Pie derecho "
            case 3:
            parte = "Pie izquierdo "
            default:
                print("Hola");
            }
            n = Int(arc4random() % 4);
            cambiarColor(number: n)
            imagen.image=image
            let result = parte+color
            resultado.text = result;
            let utterance = AVSpeechUtterance(string: result)
            utterance.voice =  AVSpeechSynthesisVoice(language: "es-ES")
            
            let synth = AVSpeechSynthesizer()
            synth.speak(utterance)
        }
    func cambiarColor( number: Int)  {
        switch number {
        case 0:
            imagen.backgroundColor = UIColor.red
                color = "rojo"
        case 1:
        imagen.backgroundColor = UIColor.blue
        color = "azul"
        case 2:
        imagen.backgroundColor = UIColor.green
        color = "verde"
        case 3:
        imagen.backgroundColor = UIColor.yellow
        color = "amarillo"
        default:
            print("Hola");
        }
    }
    
   
}

