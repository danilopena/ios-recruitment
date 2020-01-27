//
//  ExchangeService.swift
//  TechnicalTest
//
//  Created by Danilo Pena on 26/01/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import NetworkKit

final class ExchangeService <T: Codable>: HTTPClient<T> {
    func fetchLatest(completion: @escaping completion, error: @escaping error) {
        let baseUrl = Endpoint.baseUrl.rawValue
        let url = Endpoint.latestExchange.rawValue
        request(url: baseUrl + url, completion, error)
    }

}
