import UIKit

final class AlertPresenter {
    func show(in viewController: UIViewController, model: AlertModel) {
        let alert = UIAlertController(
            title: model.alertTitle,
            message: model.alertMessage,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: model.alertButtonText, style: .default) { _ in model.completion() }
        
        alert.addAction(action)
        
        viewController.present(alert, animated: true, completion:  nil)
    }
}
