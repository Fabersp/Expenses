

import Foundation

class HospedagemSolicitadoDataModel {
    
    static let Id = "Id"
    static let OnLine = "OnLine"
    static let DataEntrada = "DataEntrada"
    static let DataSaida = "DataSaida"
    static let Hotel = "Hotel"
    static let Cidade = "Cidade"
    static let TipoApto = "TipoApto"
    static let TipoCama = "TipoCama"
    static let Acompanhante = "Acompanhante"
    static let Observacao = "Observacao"
    static let  DataCancelamento = "DataCancelamento"
    static let UsuarioCancelamento = "UsuarioCancelamento"
    static let Faturamento = "Faturamento"
    
    
    var id: String?
    var onLine: Bool?
    var dataEntrada: Date?
    var dataSaida: Date?
    var hotel: String?
    var cidade: String?
    var tipoApto: String?
    var tipoCama: String?
    var acompanhante: UsuarioSimplesDataModel?
    var observacao: String?
    var dataCancelamento: Date?
    var usuarioCancelamento: UsuarioSimplesDataModel?
    var faturamento: FaturamentoDataModel?
    
    
    init(data: NSDictionary) {
        
        self.id = data[HospedagemSolicitadoDataModel.Id] as? String
        self.onLine = data[HospedagemSolicitadoDataModel.OnLine] as? Bool
        self.hotel = data[HospedagemSolicitadoDataModel.Hotel] as? String
        self.cidade = data[HospedagemSolicitadoDataModel.Cidade] as? String
        self.tipoApto = data[HospedagemSolicitadoDataModel.TipoApto] as? String
        self.tipoCama = data[HospedagemSolicitadoDataModel.TipoCama] as? String
        self.observacao = data[HospedagemSolicitadoDataModel.Observacao] as? String
        
        if let faturamentoData = data[HospedagemSolicitadoDataModel.Faturamento] as? NSDictionary {
            self.faturamento = FaturamentoDataModel(data: faturamentoData)
        }
        
        if let usuarioCancelamentoData = data[HospedagemSolicitadoDataModel.UsuarioCancelamento] as? NSDictionary {
            self.usuarioCancelamento = UsuarioSimplesDataModel(data: usuarioCancelamentoData)
        }
        
        if let dataCancelamento = data[HospedagemSolicitadoDataModel.DataCancelamento] as? String {
            self.dataCancelamento = Formatter.formatOSDate(dataCancelamento)
        }
        
        if let acompanhanteData = data[HospedagemSolicitadoDataModel.Acompanhante] as? NSDictionary {
            self.acompanhante = UsuarioSimplesDataModel(data: acompanhanteData)
        }
        
        if let dataSaida = data[HospedagemSolicitadoDataModel.DataSaida] as? String {
            self.dataSaida = Formatter.formatOSDate(dataSaida)
        }
        
        if let dataEntrada = data[HospedagemSolicitadoDataModel.DataEntrada] as? String {
            self.dataEntrada = Formatter.formatOSDate(dataEntrada)
        }
        
    }
    
}









