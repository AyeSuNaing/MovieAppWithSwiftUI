//
//  BaseDataAgent.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import Foundation
import Foundation
import Alamofire
import RxSwift


func fetchDataWithParametersObservable<T: Codable>(forEndPoint endpoint: String, parameters : [String: Any]?) -> Observable<T> {
   
    return Observable.create { observer in
        AF.request("\(BASE_URL)\(endpoint)", parameters: parameters)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let result):
                    observer.onNext(result)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
        
        return  Disposables.create()
        
    }
 
}
