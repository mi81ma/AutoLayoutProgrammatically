//
//  SwipingController.swift
//  AutoLayoutProgrammatically
//
//  Created by masato on 28/1/2019.
//  Copyright © 2019 masato. All rights reserved.
//

import UIKit


class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let pages = [
        Page(imageName: "001", headerText: "Join use today in our fun and games!", bodyText: "Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon."),
        Page(imageName: "002", headerText: "Subscribe and get coupons on our daily events", bodyText: "Get notified of the savings immediately when we announce them on our website. Make your future."),
        Page(imageName: "003", headerText: "VIP members special services", bodyText: "Thank you login as Vip."),
        Page(imageName: "001", headerText: "Join use today in our fun and games!", bodyText: "Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon."),
        Page(imageName: "002", headerText: "Subscribe and get coupons on our daily events", bodyText: "Get notified of the savings immediately when we announce them on our website. Make your future."),
        Page(imageName: "003", headerText: "VIP members special services", bodyText: "Thank you login as Vip.")
    ]

    // make sure you apply the correct encapsulation principles in your classes
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return button
    }()


    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        let pinkColor = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
        button.setTitleColor(.mainPink, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()


    @objc private func handlePrev() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .mainPink
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1) // 開かれていないページの色
        return pc
    }()


    @objc private func handleNext() {
        print("Trying to advance to next")

        // min関数を使わないと最後のページで次のページを表示しようとするとクラッシュする
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex // 表示ページをIndexPathで格納する
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
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

    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let x = targetContentOffset.pointee.x

        pageControl.currentPage = Int(x / view.frame.width)

    }


    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtonControls()

        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.isPagingEnabled = true
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell

        let page = pages[indexPath.item]
        cell.page = page



//        cell.imageView.image = UIImage(named: page.imageName)
//        cell.descriptionTextView.text = page.headerText

//        let imageName = imageNames[indexPath.item]
//        cell.imageView.image = UIImage(named: imageName)
//        cell.descriptionTextView.text = headerStrings[indexPath.item]
        //        cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .green
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }

}
