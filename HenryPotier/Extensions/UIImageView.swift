//
//  UIImageView.swift
//  HenryPotier
//
//  Created by Wassim on 29/01/2024.
//

import RxSwift
import RxCocoa
import UIKit

extension UIImageView {
    private struct AssociatedKeys {
        static var disposeBag = "disposeBag"
    }

    private var disposeBag: DisposeBag {
        get {
            if let disposeBag = objc_getAssociatedObject(self, &AssociatedKeys.disposeBag) as? DisposeBag {
                return disposeBag
            } else {
                let disposeBag = DisposeBag()
                objc_setAssociatedObject(self, &AssociatedKeys.disposeBag, disposeBag, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return disposeBag
            }
        }
    }

    func loadImage(from url: String) {
        guard let url = URL(string: url) else {
            return
        }

        URLSession.shared.rx.data(request: URLRequest(url: url))
            .observe(on:MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                if let image = UIImage(data: data) {
                    self?.image = image
                }
            }, onError: { error in
                print("Error loading image: \(error)")
            })
            .disposed(by: disposeBag)
    }
}

