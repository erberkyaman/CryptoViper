//
//  Presenter.swift
//  CryptoViper
//
//  Created by Erberk Yaman on 21.09.2024.
//

import Foundation
//Talks to -> view, interactor and router
//Class, protocol

enum NetworkError : Error {
    case NetworkFailed
    case ParsingFailed
}

protocol AnyPresenter {
    var router : AnyRouter? {get set}
    var interactor : AnyInteractor? {get set}
    var view : AnyView? {get set}
    
    func interactorDidDownloadCrypto(result : Result<[Crypto], Error>)
}

class CryptoPresenter : AnyPresenter {
    var router: (any AnyRouter)?
    
    var interactor: (any AnyInteractor)? {
        didSet {
            interactor?.downloadCryptos()
        }
    }
    
    var view: (any AnyView)?
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], any Error>) {
        switch result {
        case .success(let cryptos):
            view?.update(with: cryptos)
        case .failure(let error):
            view?.update(with: error.localizedDescription)
        }
    }
    
    
}
