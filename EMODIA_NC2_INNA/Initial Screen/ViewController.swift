//
//  ViewController.swift
//  EMODIA_NC2_INNA
//
//  Created by Nur Mutmainnah Rahim on 27/07/22.
//

import UIKit

class ViewController: UIViewController {

    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 2
        return pageControl
    }()
    
    private let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.addTarget(Self.self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
        view.addSubview(pageControl)
        view.addSubview(scrollView)
        // Do any additional setup after loading the view.
    }
    
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(current)*view.frame.size.width, y: 0), animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageControl.frame = CGRect(x: 0, y: 726.36, width: 390, height: 44)
        scrollView.frame = CGRect(x: 0, y: 662, width: 390, height: 44)
        
        if scrollView.subviews.count == 2 {
            configureScrollView()
        }
        
    }

    private func configureScrollView() {
        scrollView.contentSize = CGSize(width: view.frame.size.width*2, height: scrollView.frame.size.height)
        scrollView.isPagingEnabled = true
        
        let text: [String] = ["Improve the experience of a teacher to detect the mood of students during the learning process", "Take a picture first then the result will be automatically visible"]
        
        for x in 0..<2 {
            
            let textView = UITextView(frame: CGRect(x: CGFloat(x)*view.frame.size.width, y: 0, width: view.frame.size.width, height: scrollView.frame.size.height))
            let style = NSMutableParagraphStyle()
            style.alignment = .center
            let text = NSAttributedString(string: text[x],
                                              attributes: [NSAttributedString.Key.paragraphStyle:style])
            textView.attributedText = text
               // let page = UIView(frame: CGRect(x: CGFloat(x)*view.frame.size.width, y: 0, width: view.frame.size.width, height: scrollView.frame.size.height))
                //textView.text = text[x]
            textView.textColor = .white
            textView.backgroundColor = .black
            textView.font = UIFont.boldSystemFont(ofSize: 16)
                //textView.frame = CGRect(x: 0, y: 325, width: 842, height: 25)
               // page.backgroundColor = colors[x]
            scrollView.addSubview(textView)
                //scrollView.addSubview(page)
            
        }
    }
 


}

