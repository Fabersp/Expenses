

import Foundation

class HotelDataModel {
    
    static let Cidade = "Cidade"
    static let WebServiceId = "WebServiceId"
    static let CodIntegracao = "CodIntegracao"
    static let Nome = "Nome"
    static let Endereco = "Endereco"
    static let CEP = "CEP"
    static let Telefone = "Telefone"
    static let Email = "Email"
    static let Site = "Site"
    static let Latitude = "Latitude"
    static let Longitude = "Longitude"
    static let ISS = "ISS"
    static let TaxaTurismo = "TaxaTurismo"
    static let TaxaServico = "TaxaServico"
    static let Cafe = "Cafe"
    static let Amenidades = "Amenidades"
    static let Estrelas = "Estrelas"
    static let HotelApto = "HotelAptoRS"
    
    
    
    var cidade: String?
    var webServiceId: String?
    var codIntegracao: String?
    var nome: String?
    var endereco: String?
    var cep: String?
    var telefone: String?
    var email: String?
    var site: String?
    var latitude: Double?
    var longitude: Double?
    var iss: Double?
    var taxaTurismo: Double?
    var taxaServico: Double?
    var cafe: Double?
    var amenidades: String?
    var estrelas: Int?
    var hotelApto: HotelAptoDataModel?
    
    
    init(data: NSDictionary) {
        self.cidade = data[HotelDataModel.Cidade] as? String
        self.webServiceId = data[HotelDataModel.WebServiceId] as? String
        self.codIntegracao = data[HotelDataModel.CodIntegracao] as? String
        self.nome = data[HotelDataModel.Nome] as? String
        self.endereco = data[HotelDataModel.Endereco] as? String
        self.cep = data[HotelDataModel.CEP] as? String
        self.telefone = data[HotelDataModel.Telefone] as? String
        self.email = data[HotelDataModel.Email] as? String
        self.site = data[HotelDataModel.Site] as? String
        if let latitudeStr = data[HotelDataModel.Latitude] as? String {
            self.latitude = latitudeStr.doubleConverter
        }
        if let longitudeStr = data[HotelDataModel.Longitude] as? String {
            self.longitude = longitudeStr.doubleConverter
        }
        self.iss = data[HotelDataModel.ISS] as? Double
        self.taxaTurismo = data[HotelDataModel.TaxaTurismo] as? Double
        self.taxaServico = data[HotelDataModel.TaxaServico] as? Double
        self.cafe = data[HotelDataModel.Cafe] as? Double
        self.amenidades = data[HotelDataModel.Amenidades] as? String
        self.estrelas = data[HotelDataModel.Estrelas] as? Int
        
        if let hotelApto = data[HotelDataModel.HotelApto] as? NSDictionary {
            self.hotelApto = HotelAptoDataModel(data: hotelApto)
        }
    }
}








