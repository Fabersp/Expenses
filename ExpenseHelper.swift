

import Foundation

class ExpenseHelper {
    
    static func ReembolsoToExpense(_ reembolso: ReembolsoSolicitadoDataModel) -> ExpenseDataModel {
        
        let valor = reembolso.valor ?? 0
        let quantidade = reembolso.quantidade ?? 0
        let moeda = reembolso.moeda ?? "BRL"
        
        let expense = ExpenseDataModel(valor * Double(quantidade), description: reembolso.contaContabil ?? "", currency: moeda)
        expense.uuid = "-1"
        expense.web = true
        expense.sync = 1
        expense.description = reembolso.contaContabil
        if let data = reembolso.dataDespesaIni { expense.date = data.timeIntervalSince1970 as Double }
        else { expense.date = Date().timeIntervalSince1970 as Double }
        return expense
        
    }
    
    
}
