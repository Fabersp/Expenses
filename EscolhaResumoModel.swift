

import UIKit

class EscolhaResumoModel: NSObject {
    
    static let EscolhaResumoAereo = "EscolhaResumoAereoModel"
    
    var escolhaResumoAereo: EscolhaResumoAereoModel?
    
    //var escolhaResumoAereo
    
    init(data: NSDictionary) {
        if let escolhaResumoAereoData = data[EscolhaResumoModel.EscolhaResumoAereo] as? NSDictionary {
            self.escolhaResumoAereo = EscolhaResumoAereoModel(data: escolhaResumoAereoData)
        }
    }
    
    

}
