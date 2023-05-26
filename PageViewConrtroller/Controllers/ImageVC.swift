import UIKit

final class ImageVC: UIViewController {
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let originalImage: UIImage?
    
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
        
        if isBlackAndWhite {
            imageView.image = originalImage
            isBlackAndWhite = false
        } else {
            let ciImage = CIImage(image: imageView.image!)
            
            if let blackAndWhiteImage = applyBlackAndWhiteFilter(to: ciImage!) {
                imageView.image = UIImage(cgImage: blackAndWhiteImage)
                isBlackAndWhite = true
            }
        }
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
    
    private func applyBlackAndWhiteFilter(to image: CIImage) -> CGImage? {
        
        let filter = CIFilter(name: "CIPhotoEffectMono")
        filter?.setValue(image, forKey: kCIInputImageKey)
        
        let outputImage = filter?.outputImage
        
        let cgImage = context.createCGImage(outputImage!, from: outputImage!.extent)
        
        return cgImage
    }
    
    private func applyColorFilter(to image: CIImage) -> CGImage? {
        let filter = CIFilter(name: "CIColorControls")
        filter?.setValue(image, forKey: kCIInputImageKey)
        filter?.setValue(1.0, forKey: kCIInputSaturationKey)
        
        let outputImage = filter?.outputImage
        let cgImage = context.createCGImage(outputImage!, from: outputImage!.extent)
        
        return cgImage
    }
}
