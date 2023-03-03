//
//  OpenAIChat.swift
//  Kade-Capstone
//
//  Created by 11k on 2/27/23.
//

import Foundation
import OpenAISwift

final class APICaller{
    static let shared = APICaller()
    
    @frozen enum Constants{
        static let key = "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"
    }
    
    private var client:OpenAISwift?
    private init(){}
    
    public func setup(){
        self.client = OpenAISwift(authToken: Constants.key)
    }
    
    public func getResponse(input:String, completion: @escaping (Result<String,Error>) -> Void){
        
        client?.sendCompletion(with: input, model: .codex(.davinci), maxTokens: 500, completionHandler: { result in
            switch result{
            case .success(let model):
                print(String(describing: model.choices))
                let output = model.choices.first?.text ?? ""
                completion(.success(output))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
