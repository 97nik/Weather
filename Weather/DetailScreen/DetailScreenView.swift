//
//  DetailScreenView.swift
//  Weather
//
//  Created by Никита on 15.06.2021.
//

import Foundation
import UIKit
import SnapKit

protocol INoteScreenView: AnyObject {
	var noteText: String { get }
	func update(_ vm: DetailScreenItemViewModel)
}

final class NoteScreenView: UIView {
	
	private let labelCity: UILabel = {
		let labelCity =  UILabel()
		labelCity.font = UIFont.systemFont(ofSize: 36)
		labelCity.translatesAutoresizingMaskIntoConstraints = false
		return labelCity
	}()
	
	private let labelWeatherStatus: UILabel = {
		let label =  UILabel()
		label.font = UIFont.systemFont(ofSize: 24)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Clean"
		return label
	}()
	
	private let imageSun: UIImageView = {
		 let image = UIImageView()
		image.image = UIImage(systemName: "sun.min")
		return image
		
	}()
	
	private let labelDegrees: UILabel = {
		let label =  UILabel()
		label.font = UIFont.systemFont(ofSize: 72)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "25"
		return label
	}()
	
	private let labelDegreess: UILabel = {
		let label =  UILabel()
		label.font = UIFont.systemFont(ofSize: 72)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "25"
		return label
	}()
	private let labelDate: UILabel = {
		let label =  UILabel()
		label.font = UIFont.systemFont(ofSize: 22)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "15 june, 2021"
		return label
	}()
	
	
	private lazy var textView: UITextView = {
		var view = UITextView()
		view.backgroundColor = .secondarySystemBackground
		view.font = UIFont.systemFont(ofSize: 16)
		view.tintColor = UIColor.red
		view.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
		view.keyboardDismissMode = .interactive
		view.isScrollEnabled = true
		view.showsVerticalScrollIndicator = true
		return view
	}()
	
	var viewBot = UIView()
	

	override init(frame: CGRect = CGRect.zero) {
		super.init(frame: frame)
		self.backgroundColor = .white
		self.addSubviews()
		self.makeConstraints()
		self.setObservers()
		self.configTable()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	deinit {
		self.clearObservers()
	}
}

extension NoteScreenView: INoteScreenView {
	func update(_ vm: DetailScreenItemViewModel) {
		if vm.isEditMode == false {
			textView.becomeFirstResponder()
		} else {
		
			let attributedText = NSMutableAttributedString(string: "\(vm.name)",
														   attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .regular)])
			let titleBold = NSMutableAttributedString(string: vm.name,
													  attributes: [.font: UIFont.boldSystemFont(ofSize: 18)])
			attributedText.insert(titleBold, at: 0)
			textView.attributedText = attributedText
			labelCity.text = vm.name
		}
	}

	var noteText: String {
		return self.textView.text
	}
}

private extension NoteScreenView {
	func addSubviews() {
		self.addSubview(self.textView)
		self.addSubview(self.labelCity)
		self.addSubview(self.labelWeatherStatus)
		self.addSubview(self.imageSun)
		self.addSubview(self.labelDegrees)
		self.addSubview(self.labelDate)
		self.addSubview(self.viewBot)
		
	}
	
	private func configTable(){
//		let screenView = DetailScreenTableAdapter(style: .plain)
//		//self.addChild(screenView)
//		self.addSubview(screenView.view)
//		makeConstraint(screenView)
		let tableView = DetailScreenTableAdapter(frame: frame)

		self.viewBot.addSubview(tableView)
		//tableView.backgroundColor = .red
		tableView.delegate = tableView
		tableView.dataSource = tableView
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.snp.makeConstraints { maker in
			maker.left.right.top.bottom.equalToSuperview().inset(0)
		}
		//makeConstraint()
	}


	
	private func makeConstraints() {
//		self.textView.translatesAutoresizingMaskIntoConstraints = false
//		NSLayoutConstraint.activate([
//			self.textView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
//			self.textView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
//			self.textView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//			self.textView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor)
//		])
//
		labelCity.snp.makeConstraints { make in
			make.topMargin.equalToSuperview().inset(16)
			make.centerX.equalToSuperview()
		}
		labelWeatherStatus.snp.makeConstraints { make in
			//make.topMargin.equalToSuperview().inset(16)
			make.top.equalTo(labelCity.snp.bottomMargin).offset(12)
			make.centerX.equalToSuperview()
		}
		imageSun.snp.makeConstraints { make in
			make.width.height.equalTo(100)
			make.top.equalTo(labelWeatherStatus.snp.bottomMargin).offset(12)
			make.centerX.equalToSuperview()
		}
		labelDegrees.snp.makeConstraints { make in
			make.top.equalTo(imageSun.snp.bottomMargin).offset(12)
			make.centerX.equalToSuperview()
		}
		labelDate.snp.makeConstraints { make in
			make.top.equalTo(labelDegrees.snp.bottomMargin).offset(12)
			make.centerX.equalToSuperview()
		}
		viewBot.snp.makeConstraints { make in
			make.rightMargin.leftMargin.equalToSuperview().inset(16)
			make.top.equalTo(labelDate.snp.bottomMargin).offset(12)
			make.bottomMargin.equalToSuperview().inset(16)
		}
	}

	func setObservers() {
		NotificationCenter.default.addObserver(self,
											   selector: #selector(updateTextView(notification:)),
											   name: UIResponder.keyboardWillChangeFrameNotification,
											   object: nil)
		NotificationCenter.default.addObserver(self,
											   selector: #selector(updateTextView(notification:)),
											   name: UIResponder.keyboardWillHideNotification,
											   object: nil)
	}

	func clearObservers() {
		NotificationCenter.default.removeObserver(self)
	}

	@objc func updateTextView(notification: Notification) {
		guard let userInfo = notification.userInfo as? [String: AnyObject],
			  let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
		else { return }
		if notification.name == UIResponder.keyboardWillHideNotification {
			self.textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		} else {
			self.textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
		}
	}
}
