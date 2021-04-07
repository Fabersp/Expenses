

import UIKit

class EscolhaAereaModel: NSObject {
    
    static let SolicitacaoId = "SolicitacaoId"
    static let EscolhidoOfertado = "EscolhidoOfertado"
    static let AereaId = "AereaId"
    static let BuscaId = "BuscaId"
    static let TrechoId = "TrechoId"
    static let GrupoId = "GrupoId"
    static let CotacaoId = "CotacaoId"
    static let Escolhido = "Escolhido"
    static let Reservado = "Reservado"
    static let Emitido = "Emitido"
    static let WebServiceId = "WebServiceId"
    static let Localizador = "Localizador"
    static let DataBilhete = "DataBilhete"
    static let DataExpiracao = "DataExpiracao"
    static let Expirado = "Expirado"
    static let CiaAereaImagem = "CiaAereaImagem"
    static let CiaAereaSigla = "CiaAereaSigla"
    static let NroVoo = "NroVoo"
    static let OrigemSigla = "OrigemSigla"
    static let OrigemNome = "OrigemNome"
    static let DestinoSigla = "DestinoSigla"
    static let DestinoNome = "DestinoNome"
    static let Data = "Data"
    static let Hora = "Hora"
    static let Escala = "Escala"
    static let Conexao = "Conexao"
    static let Compartimento = "Compartimento"
    static let Equipamento = "Equipamento"
    static let MoedaBilhete = "MoedaBilhete"
    static let Valores = "Valores"
    static let ValorTotal = "ValorTotal"
    static let ValorAssentoPago = "ValorAssentoPago"
    static let MoeExiValorTotal = "MoeExiValorTotal"
    static let IndexCombinado = "IndexCombinado"
    static let ValorBilhete = "ValorBilhete"
    static let ValorTaxas = "ValorTaxas"
    static let ValorTarifaAdministrativa = "ValorTarifaAdministrativa"
    static let TaxaTua = "TaxaTua"
    static let CambioBilhete = "CambioBilhete"
    static let CambioTaxa = "CambioTaxa"
    static let BloqueiaEmissaoOnline = "BloqueiaEmissaoOnline"
    
    
    var escolhidoOfertado: String?
    var solicitacaoId: String?
    var aereaId: String?
    var buscaId: String?
    var trechoId: Int?
    var grupoId: Int?
    var cotacaoId: String?
    var escolhido: Bool?
    var reservado: Bool?
    var emitido: Bool?
    var webServiceId: String?
    var localizador: String? // trim
    var dataBilhete: Date? // "0001-01-01T00:00:00"
    var dataExpiracao: Date? // 2016-10-06T15:57:19
    var expirado: Bool?
    var ciaAereaImagem: String?
    var ciaAereaSigla: String?
    var nroVoo: String?
    var origemSigla: String?
    var origemNome: String?
    var destinoSigla: String?
    var destinoNome: String?
    var data: String?
    var hora: String?
    var escala: Int?
    var conexao: Int?
    var compartimento: String?
    var equipamento: String?
    var moedaBilhete: String?
    var valores: String?
    var valorTotal: Double?
    var valorAssentoPago: Double?
    var moeExiValorTotal: Double?
    var indexCombinado: Int?
    var valorBilhete: Double?
    var valorTaxas: Double?
    var valorTarifaAdministrativa: Double?
    var taxaTua: Double?
    var cambioBilhete: Double?
    var cambioTaxa: Double?
    var bloqueiaEmissaoOnline: Bool?
    
    
    init(data: NSDictionary) {
        self.escolhidoOfertado = data[EscolhaAereaModel.EscolhidoOfertado] as? String
        self.solicitacaoId = data[EscolhaAereaModel.SolicitacaoId] as? String
        self.aereaId = data[EscolhaAereaModel.AereaId] as? String
        self.buscaId = data[EscolhaAereaModel.BuscaId] as? String
        self.trechoId = data[EscolhaAereaModel.TrechoId] as? Int
        self.grupoId = data[EscolhaAereaModel.GrupoId] as? Int
        self.cotacaoId = data[EscolhaAereaModel.CotacaoId] as? String
        self.escolhido = data[EscolhaAereaModel.Escolhido] as? Bool
        self.reservado = data[EscolhaAereaModel.Reservado] as? Bool
        self.emitido = data[EscolhaAereaModel.Emitido] as? Bool
        self.webServiceId = data[EscolhaAereaModel.WebServiceId] as? String
        self.localizador = (data[EscolhaAereaModel.Localizador] as? String)?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        self.expirado = data[EscolhaAereaModel.Expirado] as? Bool
        self.ciaAereaImagem = data[EscolhaAereaModel.CiaAereaImagem] as? String
        self.ciaAereaSigla = data[EscolhaAereaModel.CiaAereaSigla] as? String
        self.nroVoo = data[EscolhaAereaModel.NroVoo] as? String
        self.origemSigla = data[EscolhaAereaModel.OrigemSigla] as? String
        self.origemNome = data[EscolhaAereaModel.OrigemNome] as? String
        self.destinoSigla = data[EscolhaAereaModel.DestinoSigla] as? String
        self.destinoNome = data[EscolhaAereaModel.DestinoNome] as? String
        self.data = data[EscolhaAereaModel.Data] as? String
        self.hora = data[EscolhaAereaModel.Hora] as? String
        self.escala = data[EscolhaAereaModel.Escala] as? Int
        self.conexao = data[EscolhaAereaModel.Conexao] as? Int
        self.compartimento = data[EscolhaAereaModel.Compartimento] as? String
        self.equipamento = data[EscolhaAereaModel.Equipamento] as? String
        self.moedaBilhete = data[EscolhaAereaModel.MoedaBilhete] as? String
        self.valores = data[EscolhaAereaModel.Valores] as? String
        self.valorTotal = data[EscolhaAereaModel.ValorTotal] as? Double
        self.valorAssentoPago = data[EscolhaAereaModel.ValorAssentoPago] as? Double
        self.moeExiValorTotal = data[EscolhaAereaModel.MoeExiValorTotal] as? Double
        self.indexCombinado = data[EscolhaAereaModel.IndexCombinado] as? Int
        self.valorBilhete = data[EscolhaAereaModel.ValorBilhete] as? Double
        self.valorTaxas = data[EscolhaAereaModel.ValorTaxas] as? Double
        self.valorTarifaAdministrativa = data[EscolhaAereaModel.ValorTarifaAdministrativa] as? Double
        self.taxaTua = data[EscolhaAereaModel.TaxaTua] as? Double
        self.cambioBilhete = data[EscolhaAereaModel.CambioBilhete] as? Double
        self.cambioTaxa = data[EscolhaAereaModel.CambioTaxa] as? Double
        self.bloqueiaEmissaoOnline = data[EscolhaAereaModel.BloqueiaEmissaoOnline] as? Bool
        
        
        if let dataBilheteStr = data[EscolhaAereaModel.DataBilhete] as? String {
            self.dataBilhete = Formatter.formatOSDate(dataBilheteStr)
        }
        
        if let dataExpiracaoStr = data[EscolhaAereaModel.DataExpiracao] as? String {
            self.dataExpiracao = Formatter.formatOSDate(dataExpiracaoStr)
        }
        
        
        
    }

}
