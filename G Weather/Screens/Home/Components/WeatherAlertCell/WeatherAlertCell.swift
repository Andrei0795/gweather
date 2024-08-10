//
//  WeatherAlertCell.swift
//  G Weather
//
//  Created by Andrei Ionescu on 09.08.2024.
//

import Foundation
import UIKit
import Combine

class WeatherAlertCell: BaseTableViewCell {
    @IBOutlet var shadowBorderView: UIView?
    @IBOutlet var weatherImageView : UIImageView!
    @IBOutlet var detailsStackView : UIStackView!
    @IBOutlet var nameLabel : UILabel!
    @IBOutlet var senderNameLabel : UILabel!
    @IBOutlet var startDateLabel : UILabel!
    @IBOutlet var endDateLabel : UILabel!
    @IBOutlet var durationLabel : UILabel!
    @IBOutlet var startDateTitleLabel : UILabel!
    @IBOutlet var endDateTitleLabel : UILabel!
    @IBOutlet var endDateContainer : UIView!
    @IBOutlet var durationTitleLabel : UILabel!
    @IBOutlet var durationContainer : UIView!

    private let placeholderImage = UIImage(named: "placeholder")
    private var cancellables = Set<AnyCancellable>()

    override var viewModel: BaseCellViewModel! {
        didSet {
            guard let cellVM = viewModel as? WeatherAlertCellVM else {
                return
            }
            self.cellVM = cellVM
            setupBindings()
            setupUI()
        }
    }
    
    private var cellVM: WeatherAlertCellVM!

    private func setupBorderAndShadow() {
        shadowBorderView?.layer.borderColor = UIColor.lightGray.cgColor
        shadowBorderView?.layer.borderWidth = 1.0
        
        shadowBorderView?.layer.shadowColor = UIColor.black.cgColor
        shadowBorderView?.layer.shadowOpacity = 0.25
        shadowBorderView?.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        shadowBorderView?.layer.shadowRadius = 4
        
        shadowBorderView?.layer.cornerRadius = 8
        shadowBorderView?.layer.masksToBounds = false
    }
    
    private func setupBindings() {
        cellVM.fetchedImagePublisher.sink { [unowned self] image in
            weatherImageView.image = image
        }.store(in: &cancellables)
    }
    
    private func setupUI() {
        setupBorderAndShadow()
        
        weatherImageView.image = placeholderImage
        cellVM.fetchImage()
        weatherImageView.layer.cornerRadius = 8.0
        
        nameLabel.text = cellVM.weatherItem.eventName
        startDateLabel.text = cellVM.weatherItem.startDateString
        endDateLabel.text = cellVM.weatherItem.endDateString
        durationLabel.text = cellVM.weatherItem.duration
        
        startDateTitleLabel.text = cellVM.startDateTitleText
        endDateTitleLabel.text = cellVM.endDateTitleText
        durationTitleLabel.text = cellVM.durationTitleText
        
        senderNameLabel.text = cellVM.sentByText
        
        if (cellVM.weatherItem.endDateString ?? "").isEmpty {
            endDateContainer.isHidden = true
            durationContainer.isHidden = true
        } else {
            endDateContainer.isHidden = false
            durationContainer.isHidden = false
        }
    }
}
