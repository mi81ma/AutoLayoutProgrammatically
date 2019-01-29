//
//  PageCell.swift
//  AutoLayoutProgrammatically
//
//  Created by masato on 28/1/2019.
//  Copyright © 2019 masato. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {

    var page: Page? {
        didSet {
//            print(page?.imageName)

            guard let unwrappedPage = page else { return }

            imageView.image = UIImage(named: unwrappedPage.imageName)

            let attributedText = NSMutableAttributedString(string: unwrappedPage.headerText, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
//            attributedText.append(NSAttributedString(string: "\n \n \n Are you ready for sub string writing method in to UITextView. It's easy to write by code without Storyboard.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]))

            attributedText.append(NSAttributedString(string: "\n\n\n\(unwrappedPage.bodyText)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor:UIColor.gray]))

            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center  // Textを中央へ配置
        }
    }

    private let imageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "002"))
        // this enables autolayout for our imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit // This is image aspect fit
        return imageView
    }()

    private let descriptionTextView: UITextView = {
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



    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    private func setupLayout() {

        let topImageContainerView = UIView()
        //        topImageContainerView.backgroundColor = .blue
        addSubview(topImageContainerView)
        //        topImageContainerView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)

        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false

        topImageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true

        topImageContainerView.addSubview(imageView)

        imageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true

        // 固定値で高さを決める方法
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        // 上位のViewの高さにあ応じて高さを決める方法。ここでは、50%の高さに設定
        imageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true


        // leadingAnchor and trailingAnchor are Better than leftAnchor and rightAnchor
        topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true


        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true

        addSubview(descriptionTextView)
        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
