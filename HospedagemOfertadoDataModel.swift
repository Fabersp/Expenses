

import Foundation

class HospedagemOfertadoDataModel {
    
    static let Id = "Id"
    static let Hotel = "Hotel"
    static let Apto = "Apto"
    static let Cama = "Cama"
    static let Observacao = "Observacao"
    static let Valor = "Valor"
    static let ValorTotal = "ValorTotal"
    
    var id: String?
    var hotel: String?
    var apto: String?
    var cama: String?
    var observacao: String?
    var valor: String?
    var valorTotal: Double?
    
    
    init(data: NSDictionary) {
        
        self.id = data[HospedagemOfertadoDataModel.Id] as? String
        self.hotel = data[HospedagemOfertadoDataModel.Hotel] as? String
        self.apto = data[HospedagemOfertadoDataModel.Apto] as? String
        self.cama = data[HospedagemOfertadoDataModel.Cama] as? String
        self.observacao = data[HospedagemOfertadoDataModel.Observacao] as? String
        self.valor = data[HospedagemOfertadoDataModel.Valor] as? String
        self.valorTotal = data[HospedagemOfertadoDataModel.ValorTotal] as? Double
    }
    
}
