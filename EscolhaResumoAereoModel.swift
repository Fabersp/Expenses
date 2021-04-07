

import UIKit

class EscolhaResumoAereoModel: NSObject {
    
    static let EscolhaDetalheAereoModels = "EscolhaDetalheAereoModels"
    
    var escolhaDetalhesAereo: [EscolhaDetalheAereoModel]?
    
    init(data: NSDictionary) {
        if let array = data[EscolhaResumoAereoModel.EscolhaDetalheAereoModels] as? NSArray {
            self.escolhaDetalhesAereo = [EscolhaDetalheAereoModel]()
            for detalheElement in array {
                if let detalheData = detalheElement as? NSDictionary {
                    self.escolhaDetalhesAereo?.append(EscolhaDetalheAereoModel(data: detalheData))
                }
            }
        }
    }

}
