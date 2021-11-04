//
//  ContactoCell.swift
//  AppContactos
//
//  Created by Mac15 on 04/11/21.
//

import UIKit

class ContactoCell: UITableViewCell {

    @IBOutlet weak var LBL_Nombre_Contacto: UILabel!
    @IBOutlet weak var LBL_Telefono_Contacto: UILabel!
    @IBOutlet weak var LBL_Direccion_Contacto: UILabel!
    @IBOutlet weak var IV_Foto_Contacto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
