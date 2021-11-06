//
//  ViewController.swift
//  AppContactos
//
//  Created by Mac4 on 27/10/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var TBL_Contactos: UITableView!
    
    //MARK:- Conexión a la BD
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK:- Arreglo de contactos
    var contactos = [Contacto]()
    
    //VARIABLES PARA GUARDAR LA INFORMACIÓN
    var nombre:String?
    var telefono:String?
    var direccion:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Mandamos llamar el método que creamos para leer la información de la BD
        readData()
        
        TBL_Contactos.delegate = self
        TBL_Contactos.dataSource = self
        
        //Registramos la celda personalizada que creamos
        
        TBL_Contactos.register(UINib(nibName: "ContactoCell", bundle: nil), forCellReuseIdentifier: "celda")
    }
    
    @IBAction func BTN_AgregarContacto(_ sender: UIBarButtonItem) {
        
        let alerta = UIAlertController(title: "Nuevo contacto", message: "Agregar nuevo contacto", preferredStyle: .alert)
        
        //AGREGAMOS LOS TEXTFIELD PARA EL NOMBRE, TELEFONO Y LA DIRECCION
        
        alerta.addTextField { (nombre_contacto) in
            nombre_contacto.placeholder = "Nombre"
        }
        
        alerta.addTextField { (telefono_contacto) in
            telefono_contacto.placeholder = "Teléfono"
            telefono_contacto.keyboardType = .numberPad
        }
        
        alerta.addTextField { (direccion_contacto) in
            direccion_contacto.placeholder = "Dirección"
        }
        
        let accionAceptar = UIAlertAction(title: "Aceptar", style: .default) { (_) in
            //print("Contacto Agregado")
            
            guard let texto_nombre = alerta.textFields?.first?.text else { return }
            
            guard let texto_telefono = alerta.textFields?[1].text else { return }
            
            guard let texto_direccion = alerta.textFields?[2].text else { return }
            
            //MARK:- Crear nuevo contacto
            
            let nuevoContacto = Contacto(context: self.contexto)
            
            //Asignar los parámetros
            nuevoContacto.nombre = "\(texto_nombre)"
            nuevoContacto.telefono = "\(texto_telefono)"
            nuevoContacto.direccion = "\(texto_direccion)"
            
            self.contactos.append(nuevoContacto)
            
            //Guardar contacto en la BD
            self.guardarContacto()
            
            print("\(texto_nombre)")
            print("\(texto_telefono)")
            print("\(texto_direccion)")
            
            self.TBL_Contactos.reloadData()
        }
        
        let accionCancelar = UIAlertAction(title: "Cancelar", style: .destructive, handler: nil)
        
        alerta.addAction(accionAceptar)
        alerta.addAction(accionCancelar)
        
        present(alerta, animated:true)
    }
    
    //MARK:- Método de Guardar contacto
    
    func guardarContacto()
    {
        do {
            try contexto.save()
            print("Contacto guardado exitosamente")
            
        } catch let error as NSError {
            print("Error al guardar contacto: \(error.localizedDescription)")
            
        }
    }
    
    //MARK:- Método para Leer la información de la BD
    
    func readData()
    {
        let fetchRequest : NSFetchRequest <Contacto> = Contacto.fetchRequest()
        
        do{
            contactos = try contexto.fetch(fetchRequest)
        } catch let error as NSError {
            print("Error al cargar la información: \(error.localizedDescription)")
            
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactos.count
    }
    
    //MARK:- Borrar contacto
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            //print(contactos[indexPath.row])
            contexto.delete(contactos[indexPath.row])
            contactos.remove(at: indexPath.row)
            
            guardarContacto()
        }
        TBL_Contactos.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Casteamos la celda que creamos
        
        let celda = TBL_Contactos.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! ContactoCell
        
        celda.LBL_Nombre_Contacto.text = contactos[indexPath.row].nombre
        celda.LBL_Telefono_Contacto.text = contactos[indexPath.row].telefono
        celda.LBL_Direccion_Contacto.text = contactos[indexPath.row].direccion
        celda.IV_Foto_Contacto.image = UIImage(named: "login")
        
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


