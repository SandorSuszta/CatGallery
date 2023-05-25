import UIKit

final class ImageVC: UIViewController {
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    init(imageName: String ) {
        super.init(nibName: nil, bundle: nil)
        self.imageView.image = UIImage(named: imageName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.addSubview(imageView)
        configureLayout()
        view.backgroundColor = .blue
    }
    
    private func configureLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
