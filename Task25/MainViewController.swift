
//
//  MainViewController.swift
//  Task25
//
//  Created by ana namgaladze on 10.05.24.
//

import UIKit

class MainViewController: UIViewController {
    //MARK: ---Properties
    lazy var songImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "taylor"))
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 7
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var songNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.textColor = .white
        label.text = "So Long, London"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var singerNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        label.text = "Taylor Swift"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var progressBar: UIProgressView = {
        let progressBar = UIProgressView(progressViewStyle: .bar)
        progressBar.progressTintColor = .systemBlue
        progressBar.trackTintColor = .lightGray
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    let shuffleImage = UIImageView.sfSymbolImageView(systemName: "shuffle")
    let shuffleImage1 = UIImageView.sfSymbolImageView(systemName: "shuffle")
    let skipBackImage = UIImageView.sfSymbolImageView(systemName: "backward.end")
    let skipForwardImage = UIImageView.sfSymbolImageView(systemName: "forward.end")
    let repeatImage = UIImageView.sfSymbolImageView(systemName: "repeat")
    
    lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 39.96
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 42, weight: .regular)
        let playImage = UIImage(systemName: "play", withConfiguration: symbolConfiguration)
        
        button.setImage(playImage, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 38
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.togglePlayback()
        }), for: .touchUpInside)
        return button
    }()
    
    lazy var loadingImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "loadImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var yurebisUgareshodView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "barBackgroundColor")
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 20
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tabBarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 97
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let homeTabButton = UIButton.sfSymbolButton(systemName: "house")
    let musicTabButton = UIButton.sfSymbolButton(systemName: "music.note")
    let heartTabButton = UIButton.sfSymbolButton(systemName: "heart")
    
    var isPaused = false
    var progressTimer: Timer?
    var progressValue: Float = 0.0
    var isFirstPlayTap = true
    var selectedButton: UIButton?
    //MARK: ---Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUpUI()
    }
    
    //MARK: ---Methods
    func setUpUI() {
        addSongImage()
        addLoadImageView()
        addLabelsStackView()
        addProgressBar()
        addButtonsStackView()
        addYurebisUgareshodView()
        addTabBarStackView()
    }
    
    func addSongImage() {
        view.addSubview(songImage)
        
        NSLayoutConstraint.activate([
            songImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            songImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            songImage.heightAnchor.constraint(equalToConstant: 319),
            songImage.widthAnchor.constraint(equalToConstant: 304),
        ])
    }
    
    func addLabelsStackView() {
        view.addSubview(labelsStackView)
        labelsStackView.addArrangedSubview(songNameLabel)
        labelsStackView.addArrangedSubview(singerNameLabel)
        
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: songImage.bottomAnchor, constant: 24),
            labelsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    func addLoadImageView() {
        view.addSubview(loadingImageView)
        loadingImageView.isHidden = true
        
        NSLayoutConstraint.activate([
            loadingImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 350),
            loadingImageView.centerXAnchor.constraint(equalTo: songImage.centerXAnchor),
            loadingImageView.widthAnchor.constraint(equalToConstant: 40),
            loadingImageView.heightAnchor.constraint(equalToConstant: 40),
        ])
        
    }
    
    func addProgressBar() {
        view.addSubview(progressBar)
        
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: 40),
            progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressBar.widthAnchor.constraint(equalToConstant: 331)
        ])
    }
    
    
    func addButtonsStackView() {
        view.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(shuffleImage)
        buttonsStackView.addArrangedSubview(skipBackImage)
        buttonsStackView.addArrangedSubview(button)
        buttonsStackView.addArrangedSubview(skipForwardImage)
        buttonsStackView.addArrangedSubview(repeatImage)
        
        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: progressBar.bottomAnchor,constant: 60),
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button.widthAnchor.constraint(equalToConstant: 76),
            button.heightAnchor.constraint(equalToConstant: 76),
        ])
    }
    
    func addYurebisUgareshodView() {
        view.addSubview(yurebisUgareshodView)
        
        NSLayoutConstraint.activate([
            yurebisUgareshodView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 60),
            yurebisUgareshodView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            yurebisUgareshodView.widthAnchor.constraint(equalToConstant: 335),
            yurebisUgareshodView.heightAnchor.constraint(equalToConstant: 90),
            yurebisUgareshodView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func addTabBarStackView() {
        yurebisUgareshodView.addSubview(tabBarStackView)
        tabBarStackView.addArrangedSubview(homeTabButton)
        tabBarStackView.addArrangedSubview(musicTabButton)
        tabBarStackView.addArrangedSubview(heartTabButton)
        
        homeTabButton.addAction(UIAction(handler: { [weak self] _ in
            self?.tabBarButtonTapped(self!.homeTabButton)
        }), for: .touchUpInside)
        
        musicTabButton.addAction(UIAction(handler: { [weak self] _ in
            self?.tabBarButtonTapped(self!.musicTabButton)
        }), for: .touchUpInside)
        
        heartTabButton.addAction(UIAction(handler: { [weak self] _ in
            self?.tabBarButtonTapped(self!.heartTabButton)
        }), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            tabBarStackView.topAnchor.constraint(equalTo: yurebisUgareshodView.topAnchor, constant: 23),
            tabBarStackView.centerXAnchor.constraint(equalTo: yurebisUgareshodView.centerXAnchor),
        ])
    }
    
    func tabBarButtonTapped(_ sender: UIButton) {
        
        guard sender != selectedButton else { return }
        
        if let selectedButton = selectedButton {
            UIView.animate(withDuration: 0.2) {
                selectedButton.transform = .identity
                selectedButton.tintColor = .systemGray
            }
        }
        
        selectedButton = sender
        
        UIView.animate(withDuration: 0.2) {
            sender.transform = CGAffineTransform(scaleX: 2, y: 2)
            sender.tintColor = .systemBlue
        }
        
    }
    
    func togglePlayback() {
        isPaused.toggle()
        let imageName = isPaused ? "pause" : "play"
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 35, weight: .regular)
        let image = UIImage(systemName: imageName, withConfiguration: symbolConfiguration)
        button.setImage(image, for: .normal)
        
    if isPaused {
        if isFirstPlayTap {
            isFirstPlayTap = false
        } else {
            loadingImageView.isHidden = false
            
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveLinear, .repeat], animations: {
                self.loadingImageView.transform = self.loadingImageView.transform.rotated(by: .pi)
            }, completion: nil)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.loadingImageView.isHidden = true
                
                self.progressTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
                    guard let self = self else { return }
                    if self.progressValue >= 1.0 {
                        self.progressTimer?.invalidate()
                        return
                    }
                    self.progressValue += 0.01
                    self.progressBar.setProgress(self.progressValue, animated: true)
                }
                
                UIView.animate(withDuration: 1) {
                    self.songImage.transform = .identity
                }
            }
        }
    } else {
        
        progressTimer?.invalidate()
        UIView.animate(withDuration: 0.5) {
            self.songImage.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }
    }
}
}


#Preview {
    MainViewController()
}
