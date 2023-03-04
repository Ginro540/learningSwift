//
//  ViewController.swift
//  rxStudy
//
//  Created by 古賀貴伍社用 on 2023/03/04.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    
    @IBOutlet weak var textField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testFilter()
        testMap()
        methodChain()
        testSubject()
        // Do any additional setup after loading the view.
    }


//    extension ObservableType {
//        public func filter(_ predicate: @escaping (Self.E) throws -> Bool)-> RxSwift.Observable<Self.E>
//    }

    func testFilter(){
        
        print("##########  testFilter  ########")
        
        let observable = Observable.of(
            "R",
            "Rx",
            "RxS",
            "RxSw",
            "RxSwi",
            "RxSwif",
            "RxSwift"
        )
        _ = observable
            .filter{ $0.count >= 2 } // ２文字以上の場合
            .subscribe(onNext: {
                print("onNext:",$0)
            })
    }
    
    func testMap(){
        print("##########  testMap  ########")
        let observable = Observable.of(
            "R",
            "Rx",
            "RxS",
            "RxSw",
            "RxSwi",
            "RxSwif",
            "RxSwift"
        )
        _ = observable
            .filter{  $0.count >= 2}
            .map{ $0.lowercased()}
            .subscribe(onNext: {
                print("onNext:",$0)
            })
    }
    
    func methodChain() {
        print("##########  methodChainその１  ########")
        _ = Observable.just(10)
            .map{ $0 * 2 }
            .subscribe(onNext: {
                print($0)
            })
        
        print("##########  methodChainその２  ########")
        print("methodChainその1を省略しないで記載する")
        _ = Observable.just(10)
            .map { (arg: Int) -> Int in
                return arg * 2
            }
            .subscribe(onNext: { (arg: Int) -> Void in
                print(arg)
            })
        
        print("##########  methodChainその３  ########")

        _ = Observable.just(10)
            .map{ (arg: Int) -> String in
                return "value: \(arg)"
            }
            .subscribe(onNext: { (arg: String) -> Void in
                print(arg)
            })
    }
    

    func testSubject(){
        
        print("##########  testSubject  ########")
        let subject = PublishSubject<String>()
        _ = subject.subscribe(onNext: {
            print("onNext:", $0)
        })
        subject.onNext("A")
        subject.onNext("B")
        subject.onNext("C")
        subject.onNext("D")
        subject.onCompleted()
    }
    
    
    
    
    
}

