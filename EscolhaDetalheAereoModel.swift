

import UIKit

class EscolhaDetalheAereoModel: NSObject {
    
    static let TrechoId = "TrechoId"
    static let BuscaId = "BuscaId"
    static let Descricao = "Descricao"
    static let EscolhaAereaModels = "EscolhaAereaModels"
    
    var trechoId: Int?
    var buscaId: Int?
    var descricao: String?
    
    var escolhaAereaModels: [EscolhaAereaModel]?
    
    init(data: NSDictionary) {
        
        trechoId = data[EscolhaDetalheAereoModel.TrechoId] as? Int
        buscaId = data[EscolhaDetalheAereoModel.BuscaId] as? Int
        descricao = data[EscolhaDetalheAereoModel.Descricao] as? String
        
        
        if let escolhaAereaArray = data[EscolhaDetalheAereoModel.EscolhaAereaModels] as? NSArray {
            escolhaAereaModels = [EscolhaAereaModel]()
            for escolhaAereaElement in escolhaAereaArray {
                if let escolhaAereaData = escolhaAereaElement as? NSDictionary {
                    escolhaAereaModels?.append(EscolhaAereaModel(data: escolhaAereaData))
                }
            }
        }
        
    }

}
