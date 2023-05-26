import UIKit

final class ImageViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private var originalImage: UIImage?
    
    private var blackAndWhiteImage: UIImage?
    
    private var isBlackAndWhite: Bool = false
    
    private let context = CIContext()
    
    //MARK: - Init
    
    init(imageName: String ) {
        self.originalImage = UIImage(named: imageName)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        view.addSubview(imageView)
        view.backgroundColor = .systemBackground
        imageView.image = originalImage
        configureLayout()
        applyShadow()
    }
    
    //MARK: - API
    
    func toggleBlackAndWhite() {
        imageView.image = isBlackAndWhite
            ? originalImage
            : applyBlackAndWhiteFilter(to: imageView.image!)
        
        isBlackAndWhite.toggle()
    }
    
    //MARK: - Private methods
    
    private func configureLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 350),
            imageView.widthAnchor.constraint(equalToConstant: 350)
        ])
    }
    
    private func applyShadow() {
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowOffset = CGSize(width: 0, height: 5)
        imageView.layer.shadowRadius = 5
    }
    
    private func applyBlackAndWhiteFilter(to image: UIImage) -> UIImage {
        if let blackAndWhiteImage {
            return blackAndWhiteImage
        } else {
            let ciImage = CIImage(image: image)
            let filter = CIFilter(name: "CIPhotoEffectMono")
            filter?.setValue(ciImage, forKey: kCIInputImageKey)
            let outputImage = filter?.outputImage
            let image = UIImage(cgImage: context.createCGImage(outputImage!, from: outputImage!.extent)!)
            
            blackAndWhiteImage = image
            return image
        }
    }
}
