
import Foundation

class HotelAptoDataModel {
    
    static let HotelId = "HotelId"
    static let Nome = "Nome"
    static let TipoApto = "TipoApto"
    static let AptoId = "AptoId"
    static let Validade = "Validade"
    static let Moeda = "Moeda"
    static let ValorDiaria = "ValorDiaria"
    
    
    var hotelId: String?
    var nome: String?
    var tipoApto: Character?
    var aptoId: Int?
    var validade: String?
    var moeda: String?
    var valorDiaria: Double?
    
    
    init(data: NSDictionary) {
        
        self.hotelId = data[HotelAptoDataModel.HotelId] as? String
        self.nome = data[HotelAptoDataModel.Nome] as? String
        self.tipoApto = data[HotelAptoDataModel.TipoApto] as? Character
        self.aptoId = data[HotelAptoDataModel.AptoId] as? Int
        self.validade = data[HotelAptoDataModel.Validade] as? String
        self.moeda = data[HotelAptoDataModel.Moeda] as? String
        self.valorDiaria = data[HotelAptoDataModel.ValorDiaria] as? Double
    }
}
