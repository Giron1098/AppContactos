//
//  ViewController.swift
//  AppContactos
//
//  Created by Mac4 on 27/10/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TBL_Contactos: UITableView!
    
    //VARIABLES PARA GUARDAR LA INFORMACIÓN
    var nombre:String?
    var telefono:String?
    var direccion:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TBL_Contactos.delegate = self
        TBL_Contactos.dataSource = self
    }
    
    @IBAction func BTN_AgregarContacto(_ sender: UIBarButtonItem) {
        
        let alerta = UIAlertController(title: "Nuevo contacto", message: "Agregar nuevo contacto", preferredStyle: .alert)
        
        //AGREGAMOS LOS TEXTFIELD PARA EL NOMBRE, TELEFONO Y LA DIRECCION
        
        alerta.addTextField { (nombre_contacto) in
            nombre_contacto.placeholder = "Nombre"
        }
        
        alerta.addTextField { (telefono_contacto) in
            telefono_contacto.placeholder = "Teléfono"
        }
        
        alerta.addTextField { (direccion_contacto) in
            direccion_contacto.placeholder = "Dirección"
        }
        
        let accionAceptar = UIAlertAction(title: "Aceptar", style: .default) { (_) in
            print("Contacto Agregado")
            
            guard let texto_nombre = alerta.textFields?.first?.text else { return }
            
            guard let texto_telefono = alerta.textFields?[1].text else { return }
            
            guard let texto_direccion = alerta.textFields?[2].text else { return }
            
            print("\(texto_nombre)")
            print("\(texto_telefono)")
            print("\(texto_direccion)")
        }
        
        let accionCancelar = UIAlertAction(title: "Cancelar", style: .destructive, handler: nil)
        
        alerta.addAction(accionAceptar)
        alerta.addAction(accionCancelar)
        
        present(alerta, animated:true)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = TBL_Contactos.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        
        celda.textLabel?.text = "Hola"
        
        return celda
    }
    
    //CUANDO EL USUARIO SELECCIONA UN ELEMENTO
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //ANIMACIÓN DE SELECCIÓN DE CELDA
        
        TBL_Contactos.deselectRow(at: indexPath, animated: true)
        
        
        
        performSegue(withIdentifier: "editarContacto", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editarContacto"
        {
            let objEditar = segue.destination as! EditarContactoViewController
            
            //objEditar.nombre_recibido =
        }
    }
    
}


