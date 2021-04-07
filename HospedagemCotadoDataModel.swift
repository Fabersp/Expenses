
import Foundation

class HospedagemCotadoDataModel {
    
    static let Id = "Id"
    static let CotacaoId = "CotacaoId"
    static let OnLine = "OnLine"
    static let HotelDados = "HotelDados"
    static let Hotel = "Hotel"
    static let Cidade = "Cidade"
    static let Estado = "Estado"
    static let Localizacao = "Localizacao"
    static let Pais = "Pais"
    static let Faturamento = "Faturamento"
    static let JustificativasTrecho = "JustificativasTrecho"
    static let QtdDiaria = "QtdDiaria"
    static let Moeda = "Moeda"
    static let MoedaCodigoBacen = "MoedaCodigoBacen"
    static let ValorDiaria = "ValorDiaria"
    static let ValorTotal = "ValorTotal"
    static let ValorTotalAprovado = "ValorTotalAprovado"
    static let WebService = "WebService"
    static let Observacao = "Observacao"
    static let Voucher = "Voucher"
    static let DataVoucher = "DataVoucher"
    static let DataCancelamento = "DataCancelamento"
    static let UsuarioCancelamento = "UsuarioCancelamento"
    static let Atendente = "Atendente"
    static let Emissor = "Emissor"
    static let HospedagemOfertado = "HospedagemOfertado"
    static let TipoApto = "TipoApto"
    static let TipoCama = "TipoCama"
    static let ValorDiariaMais = "ValorDiariaMais"
    static let ValorDiariaMenos = "ValorDiariaMenos"
    static let PercDiariaMais = "PercDiariaMais"
    static let PercDiariaMenos = "PercDiariaMenos"
    static let PercTotalMais = "PercTotalMais"
    static let PercTotalMenos = "PercTotalMenos"
    static let FeesTrecho = "FeesTrecho"
    static let ValorTotalCambio = "ValorTotalCambio"
    static let MoedaCambio = "MoedaCambio"
    
    
    
    var onLine: Bool?
    var cotacaoId: String?
    var id: String?
    var hotelDados: HotelDataModel?
    var hotel: String?
    var cidade: String?
    var estado: String?
    var localizacao: String?
    var pais: String?
    var faturamento: FaturamentoDataModel?
    var justificativasTrecho: [JustificativaDataModel]?
    var qtdDiaria: Int?
    var moeda: String?
    var moedaCodigoBacen: String?
    var valorDiaria: Double?
    var valorTotal: Double?
    var valorTotalAprovado: Double?
    var webService: String?
    var observacao: String?
    var voucher: String?
    var dataVoucher: Date?
    var dataCancelamento: Date?
    var usuarioCancelamento: UsuarioSimplesDataModel?
    var atendente: UsuarioSimplesDataModel?
    var emissor: UsuarioSimplesDataModel?
    var hospedagemOfertado: [HospedagemOfertadoDataModel]?
    var tipoApto: String?
    var tipoCama: String?
    var valorDiariaMais: Double?
    var valorDiariaMenos: Double?
    var percDiariaMais: Double?
    var percDiariaMenos: Double?
    var percTotalMais: Double?
    var percTotalMenos: Double?
    var feesTrecho: [FeeDataModel]?
    var valorTotalCambio: Double?
    var moedaCambio: String?
    
    
    
    init(data: NSDictionary) {
        
        self.id = data[HospedagemCotadoDataModel.Id] as? String
        self.cotacaoId = data[HospedagemCotadoDataModel.CotacaoId] as? String
        self.onLine = data[HospedagemCotadoDataModel.OnLine] as? Bool
        self.hotel = data[HospedagemCotadoDataModel.Hotel] as? String
        self.cidade = data[HospedagemCotadoDataModel.Cidade] as? String
        self.estado = data[HospedagemCotadoDataModel.Estado] as? String
        self.localizacao = data[HospedagemCotadoDataModel.Localizacao] as? String
        self.pais = data[HospedagemCotadoDataModel.Pais] as? String
        self.qtdDiaria = data[HospedagemCotadoDataModel.QtdDiaria] as? Int
        self.moeda = data[HospedagemCotadoDataModel.Moeda] as? String
        self.moedaCodigoBacen = data[HospedagemCotadoDataModel.MoedaCodigoBacen] as? String
        self.valorDiaria = data[HospedagemCotadoDataModel.ValorDiaria] as? Double
        self.valorTotal = data[HospedagemCotadoDataModel.ValorTotal] as? Double
        self.valorTotalAprovado = data[HospedagemCotadoDataModel.ValorTotalAprovado] as? Double
        self.webService = data[HospedagemCotadoDataModel.WebService] as? String
        self.observacao = data[HospedagemCotadoDataModel.Observacao] as? String
        self.voucher = data[HospedagemCotadoDataModel.Voucher] as? String
        self.tipoApto = data[HospedagemCotadoDataModel.TipoApto] as? String
        self.tipoCama = data[HospedagemCotadoDataModel.TipoCama] as? String
        self.valorDiariaMais = data[HospedagemCotadoDataModel.ValorDiariaMais] as? Double
        self.valorDiariaMenos = data[HospedagemCotadoDataModel.ValorDiariaMenos] as? Double
        self.percDiariaMais = data[HospedagemCotadoDataModel.PercDiariaMais] as? Double
        self.percDiariaMenos = data[HospedagemCotadoDataModel.PercDiariaMenos] as? Double
        self.percTotalMais = data[HospedagemCotadoDataModel.PercTotalMais] as? Double
        self.percTotalMenos = data[HospedagemCotadoDataModel.PercTotalMenos] as? Double
        self.moedaCambio = data[HospedagemCotadoDataModel.MoedaCambio] as? String
        self.valorTotalCambio = data[HospedagemCotadoDataModel.ValorTotalCambio] as? Double
        
        if let feesTrechoArray = data[HospedagemCotadoDataModel.FeesTrecho] as? NSArray {
            self.feesTrecho = [FeeDataModel]()
            for fee in feesTrechoArray {
                if let feeData = fee as? NSDictionary {
                    self.feesTrecho?.append(FeeDataModel(data: feeData))
                }
            }
        }
        
        if let hospedagemOfertadoArray = data[HospedagemCotadoDataModel.HospedagemOfertado] as? NSArray {
            self.hospedagemOfertado = [HospedagemOfertadoDataModel]()
            for hospedagemOfertado in hospedagemOfertadoArray {
                if let hospedagemOfertadoData = hospedagemOfertado as? NSDictionary {
                    self.hospedagemOfertado?.append(HospedagemOfertadoDataModel(data: hospedagemOfertadoData))
                }
            }
        }
        
        if let emissorData = data[HospedagemCotadoDataModel.Emissor] as? NSDictionary {
            self.emissor = UsuarioSimplesDataModel(data: emissorData)
        }
        
        if let atendenteData = data[HospedagemCotadoDataModel.Atendente] as? NSDictionary {
            self.atendente = UsuarioSimplesDataModel(data: atendenteData)
        }
        
        if let usuarioCancelamentoData = data[HospedagemCotadoDataModel.UsuarioCancelamento] as? NSDictionary {
            self.usuarioCancelamento = UsuarioSimplesDataModel(data: usuarioCancelamentoData)
        }
        
        if let dataCancelamento = data[HospedagemCotadoDataModel.DataCancelamento] as? String {
            self.dataCancelamento = Formatter.formatOSDate(dataCancelamento)
        }
        
        if let dataVoucher = data[HospedagemCotadoDataModel.DataVoucher] as? String {
            self.dataVoucher = Formatter.formatOSDate(dataVoucher)
        }
        
        if let justificativasTrechoArray = data[HospedagemCotadoDataModel.JustificativasTrecho] as? NSArray {
            
            self.justificativasTrecho = [JustificativaDataModel]()
            
            for justificativasTrecho in justificativasTrechoArray {
                if let justificativasTrechoData = justificativasTrecho as? NSDictionary {
                    self.justificativasTrecho?.append(JustificativaDataModel(data: justificativasTrechoData))
                }
            }
        }
        
        if let faturamentoData = data[HospedagemCotadoDataModel.Faturamento] as? NSDictionary {
            self.faturamento = FaturamentoDataModel(data: faturamentoData)
        }
        
        if let hotelData = data[HospedagemCotadoDataModel.HotelDados] as? NSDictionary {
            self.hotelDados = HotelDataModel(data: hotelData)
        }
        
    }
    
}










