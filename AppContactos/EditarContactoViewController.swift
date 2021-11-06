//
//  EditarContactoViewController.swift
//  AppContactos
//
//  Created by Mac15 on 02/11/21.
//

import UIKit
import CoreData

class EditarContactoViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var TF_Nombre: UITextField!
    @IBOutlet weak var TF_Telefono: UITextField!
    @IBOutlet weak var TF_Direccion: UITextField!
    @IBOutlet weak var IV_Imagen_Perfil: UIImageView!
    
    //MARK:- Conexión a la BD
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK:- Arreglo de contactos
    var contactos = [Contacto]()
    
    //VARIABLES PARA RECIBIR LOS DATOS
    
    var nombre_recibido:String?
    var telefono_recibido:String?
    var direccion_recibida:String?
    var posicion_recibida:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Consultar a la BD
        readData()
        
        TF_Nombre.text = nombre_recibido
        TF_Telefono.text = telefono_recibido
        TF_Direccion.text = direccion_recibida
        
        //MARK:- AGREGAR GESTURA A LA IMAGEN
        let gesturaRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickImagen))
        gesturaRecognizer.numberOfTouchesRequired = 1
        gesturaRecognizer.numberOfTapsRequired = 1
        IV_Imagen_Perfil.addGestureRecognizer(gesturaRecognizer)
        IV_Imagen_Perfil.isUserInteractionEnabled = true
        
    }
    
    @objc func clickImagen(gestura:UITapGestureRecognizer)
    {
        print("Cambiar imagen")
        let vc_cambiar_imagen = UIImagePickerController()
        vc_cambiar_imagen.sourceType = .photoLibrary
        vc_cambiar_imagen.delegate = self
        vc_cambiar_imagen.allowsEditing = true
        
        present(vc_cambiar_imagen, animated: true, completion: nil)

    }
    
    //MARK:- Método para detectar cuando el usuario terminó de elegir una imagen
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let userPickedImage = info[.editedImage] as? UIImage else { return }
        IV_Imagen_Perfil.image = userPickedImage
        
        //Ocultar el picker
        picker.dismiss(animated: true, completion: nil)
    }

    @IBAction func BTN_Cancelar(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func BTN_Guardar(_ sender: UIButton) {
        
        do {
            
            if let pos = posicion_recibida
            {
                contactos[pos].setValue(TF_Nombre.text, forKey: "nombre")
                contactos[pos].setValue(TF_Telefono.text, forKey: "telefono")
                contactos[pos].setValue(TF_Direccion.text, forKey: "direccion")
                //contactos[pos].setValue(IV_Imagen_Perfil.image?.pngData(), forKey: "image")
            }
            
            try self.contexto.save()
            
            print("Contacto editado")
        } catch let error as NSError {
            print("Error al realizar los cambios: \(error.localizedDescription)")
        }
        
        TF_Nombre.text = ""
        TF_Telefono.text = ""
        TF_Direccion.text = ""
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func BTN_AbrirCamara(_ sender: UIBarButtonItem) {
        print("ABRIR CÁMARA DEL DISPOSITIVO")
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
    
    //OCULTAR TECLADO
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
