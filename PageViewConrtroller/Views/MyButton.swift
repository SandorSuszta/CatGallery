import UIKit

final class MyButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        setupButton(withTitle: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton(withTitle title: String) {
        backgroundColor = .black
        setTitleColor(.white, for: .normal)
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
        layer.cornerRadius = 6
    }
}
