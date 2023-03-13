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
        combineLatest()
        combineLatestaa()
        zip()
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
    
    
    
    func combineLatest(){
        print("##########  combineLatest  ########")
        let password = PublishSubject<String>()
        let repeatedPassword = PublishSubject<String>()
        _ = Observable.combineLatest(password, repeatedPassword) { "\($0), \($1)"}
              .subscribe(onNext: { print("onNext: ", $0) })
        
        
        password.onNext("a")
        password.onNext("ab")
        repeatedPassword.onNext("A")
        repeatedPassword.onNext("AB")
        repeatedPassword.onNext("ABC")
        
        
    }
    
    func combineLatestaa(){
        print("##########  combineLatestaa  ########")
        let password = PublishSubject<String>()
        let repeatedPassword = PublishSubject<String>()
        _ = Observable.combineLatest(password, repeatedPassword) { "\($0), \($1)"}
              .subscribe(onNext: { print("onNext: ", $0) })
        
        repeatedPassword.onNext("A")
        repeatedPassword.onNext("AB")
        repeatedPassword.onNext("ABC")
        password.onNext("a")
        password.onNext("ab")
    }
    
    func zip(){
        print("##########  zip  ########")
        let intSubject = PublishSubject<Int>()
        let stringSubject = PublishSubject<String>()
        
        _ = Observable.zip(intSubject, stringSubject) {
                "\($0) \($1)"
            }
            .subscribe(onNext: { print($0) })
        intSubject.onNext(1)
        intSubject.onNext(2)
        stringSubject.onNext("A")
        stringSubject.onNext("B")
        stringSubject.onNext("C")
        stringSubject.onNext("D")
        intSubject.onNext(3)
        intSubject.onNext(4)
    }
    
    public enum TestError: Error {
        case test
    }
    
    
    
    
    
    
    func errors(){
        let sequenceThatErrors = Observable<String>.create { observer in
            
            observer.onNext("A")
            observer.onError(TestError.test)
            observer.onNext("B")
            return Disposables.create(){
                print("Dispose Action:")
            }
            
        }
        
        
        
        
        
    }
    
    
}

