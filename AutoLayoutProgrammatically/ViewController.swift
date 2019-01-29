//
//  ViewController.swift
//  AutoLayoutProgrammatically
//
//  Created by masato on 27/1/2019.
//  Copyright © 2019 masato. All rights reserved.
//

import UIKit

extension UIColor {
    static var mainPink = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
}

class ViewController: UIViewController {

    // let's avoid poluuting viewDidLoad
    // {} is referred to as closure, or anonymouse funtcions
    let imageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "002"))
        // this enables autolayout for our imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit // This is image aspect fit
        return imageView
    }()


    let descriptionTextView: UITextView = {
        let textView = UITextView()

        let attributedText = NSMutableAttributedString(string: "THIS IS TITLE TEXT!", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        attributedText.append(NSAttributedString(string: "\n \n \n Are you ready for sub string writing method in to UITextView. It's easy to write by code without Storyboard.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]))

        textView.attributedText = attributedText

//        textView.text = "THIS IS TITLE TEXT!"
//        textView.font = UIFont.boldSystemFont(ofSize: 18)

        textView.translatesAutoresizingMaskIntoConstraints = false // This is important to use Autorayout by Cording

        textView.textAlignment = .center
        textView.isEditable = false  // Cancel Edit Keyboard
        textView.isScrollEnabled = false

        return textView
    }()

    // make sure you apply the correct encapsulation principles in your classes
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()


    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        let pinkColor = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
        button.setTitleColor(.mainPink, for: .normal)
        return button
    }()

    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
//        pc.currentPageIndicatorTintColor = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1) // 現在のページの色
        pc.currentPageIndicatorTintColor = .mainPink
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1) // 開かれていないページの色
        return pc
    }()


    override func viewDidLoad() {
        super.viewDidLoad()



       // here's our entry point into our app
//        view.addSubview(imageView)
        view.addSubview(descriptionTextView)
        setupButtonControls()
        setupLayout()
    }


    fileprivate func setupButtonControls() {

        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
//        bottomControlsStackView.axis = .vertical

        view.addSubview(bottomControlsStackView)

        NSLayoutConstraint.activate([
//            previousButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }


    private func setupLayout() {

        let topImageContainerView = UIView()
//        topImageContainerView.backgroundColor = .blue
        view.addSubview(topImageContainerView)
//        topImageContainerView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)

        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false

        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true

        topImageContainerView.addSubview(imageView)

        imageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true

        // 固定値で高さを決める方法
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        // 上位のViewの高さにあ応じて高さを決める方法。ここでは、50%の高さに設定
        imageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true


        // leadingAnchor and trailingAnchor are Better than leftAnchor and rightAnchor
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true


        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true

        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}

