//
//  MainViewModel.swift
//  Task25
//
//  Created by ana namgaladze on 10.05.24.
//
//

import Foundation
protocol MainViewModelDelegate: AnyObject {
    func startLoadingAnimation()
    func stopLoadingAnimation()
    func setProgress(progressValue: Float, animated: Bool)
    func resetSongImageTransform()
    func transformImageToSmall()
    func configureUpdateButtonImage(isPaused: String)
    func didUpdateSelectedTabIndex(selectedIndex: Int)
}

final class MainViewModel {
    weak var delegate: MainViewModelDelegate?
    
    private var isPaused = false
    private var isFirstPlayTap = true
    private var progressTimer: Timer?
    private var progressValue: Float = 0.0
    var selectedTabIndex: Int = 0 {
        didSet {
            delegate?.didUpdateSelectedTabIndex(selectedIndex: selectedTabIndex)
        }
    }
    
    func togglePlayback() {
        isPaused.toggle()
        updateButtonImage()
        
        if isPaused {
            handlePause()
        } else {
            handleResume()
        }
    }
    
    private func handlePause() {
        if isFirstPlayTap {
            isFirstPlayTap = false
        } else {
            delegate?.startLoadingAnimation()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.delegate?.stopLoadingAnimation()
                self.startProgressTimer()
                self.delegate?.resetSongImageTransform()
            }
        }
    }
    
    private func handleResume() {
        progressTimer?.invalidate()
        delegate?.transformImageToSmall()
    }
    
    private func startProgressTimer() {
        progressTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            self.progressValue += 0.01
            self.delegate?.setProgress(progressValue: self.progressValue, animated: true)
        }
    }
    
    func updateButtonImage() {
        let imageName = isPaused ? "pause" : "play"
        delegate?.configureUpdateButtonImage(isPaused: imageName)
    }
        
}




