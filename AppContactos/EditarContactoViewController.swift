//
//  EditarContactoViewController.swift
//  AppContactos
//
//  Created by Mac15 on 02/11/21.
//

import UIKit

class EditarContactoViewController: UIViewController {

    @IBOutlet weak var TF_Nombre: UITextField!
    @IBOutlet weak var TF_Telefono: UITextField!
    @IBOutlet weak var TF_Direccion: UITextField!
    
    //VARIABLES PARA RECIBIR LOS DATOS
    
    var nombre_recibido:String?
    var telefono_recibido:String?
    var direccion_recibida:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func BTN_Cancelar(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func BTN_Guardar(_ sender: UIButton) {
    }
    
}
